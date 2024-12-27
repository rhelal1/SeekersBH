import FirebaseFirestore

class CourseManager {
    
    static let share = CourseManager()
    private let db = Firestore.firestore()

    func fetchAllCourses() async throws -> [Course] {
        let snapshot = try await db.collection("OnlineCourses").getDocuments()
        
        return try await withThrowingTaskGroup(of: Course?.self) { group in
            for document in snapshot.documents {
                group.addTask {
                    try await self.fetchCourseDetails(courseId: document.documentID, data: document.data())
                }
            }
            
            // Collect results
            var courses = [Course]()
            for try await course in group {
                if let course = course {
                    courses.append(course)
                }
            }
            return courses
        }
    }

    private func fetchCourseDetails(courseId: String, data: [String: Any]?) async throws -> Course {
        guard let data = data,
                 let id = data["id"] as? String,
                 let title = data["title"] as? String,
                 let rating = data["rating"] as? Double,
                 let description = data["description"] as? String,
                 let instructor = data["instructor"] as? String,
                 let prerequisites = data["prerequisites"] as? String,
                 let outcomes = data["outcomes"] as? String,
                 let categoryRaw = data["category"] as? String,
                 let category = CourseCategory(rawValue: categoryRaw),
                 let pictureUrl = data["pictureUrl"] as? String else {
               throw NSError(domain: "CourseError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Course not found or failed to parse data"])
           }

           // Create the course object including courseId
           var course = Course(id: id, title: title, rating: rating, description: description,
                               instructor: instructor, prerequisites: prerequisites, outcomes: outcomes,
                               category: category, pictureUrl: pictureUrl,  // Assign pictureUrl
                               courseComments: [], courseContent: [], courseQuestions: [])

           let courseRef = db.collection("OnlineCourses").document(courseId)

           // Fetch related collections concurrently
           async let comments = fetchComments(for: courseRef)
           async let content = fetchContent(for: courseRef)
           async let questions = fetchQuestions(for: courseRef)

           // Aggregate fetched data
           course.courseComments = try await comments
           course.courseContent = try await content
           course.courseQuestions = try await questions

           return course
    }

    private func fetchComments(for courseRef: DocumentReference) async throws -> [CourseComments] {
        let snapshot = try await courseRef.collection("courseComments").getDocuments()
        return snapshot.documents.compactMap { parseCourseCommentData(data: $0.data()) }
    }

    private func fetchContent(for courseRef: DocumentReference) async throws -> [CourseContent] {
        let snapshot = try await courseRef.collection("courseContent").getDocuments()
        
        // Parse the documents and sort them by title
        let content = snapshot.documents.compactMap { parseCourseContentData(data: $0.data()) }
        
        // Sort content based on the title
        return content.sorted { $0.title < $1.title }
    }

    private func fetchQuestions(for courseRef: DocumentReference) async throws -> [Question] {
        let snapshot = try await courseRef.collection("courseQuestions").getDocuments()

        return try await withThrowingTaskGroup(of: Question?.self) { group in
            for document in snapshot.documents {
                group.addTask {
                    try await self.parseQuestionData(data: document.data(), documentRef: document.reference)
                }
            }

            // Collect results
            var questions = [Question]()
            for try await question in group {
                if let question = question {
                    questions.append(question)
                }
            }
            return questions
        }
    }

    private func parseCourseCommentData(data: [String: Any]) -> CourseComments? {
        guard let userId = data["user_id"] as? Int,
              let commentText = data["commenttext"] as? String,
              let rated = data["rated"] as? Int else {
            return nil
        }
        return CourseComments(userId: userId, commenttext: commentText, rated: rated)
    }

    private func parseCourseContentData(data: [String: Any]) -> CourseContent? {
        guard let title = data["title"] as? String,
              let duration = data["duration"] as? Int,
              let description = data["description"] as? String,
              let videoUrl = data["videoUrl"] as? String else {
            return nil
        }
        return CourseContent(title: title, duration: duration, description: description, videoUrl: videoUrl)
    }

    private func parseQuestionData(data: [String: Any], documentRef: DocumentReference) async throws -> Question? {
        guard let questionTxt = data["questionTxt"] as? String,
              let correctAnswer = data["correctAnswer"] as? String,
              let points = data["points"] as? Int else {
            return nil
        }

        let optionsSnapshot = try await documentRef.collection("options").getDocuments()
        guard let optionsDocument = optionsSnapshot.documents.first else {
            return nil
        }

        guard let option1 = optionsDocument.data()["option1"] as? String,
              let option2 = optionsDocument.data()["option2"] as? String,
              let option3 = optionsDocument.data()["option3"] as? String,
              let option4 = optionsDocument.data()["option4"] as? String else {
            return nil
        }

        let options = [option1, option2, option3, option4]
        return Question(questionTxt: questionTxt, options: options, correctAnswer: correctAnswer, points: points)
    }
    
    func fetchTheUserCVs(forUserID userID: String) async throws -> [String] {
        let db = Firestore.firestore()
           
           // Reference to the "CV" collection
           let cvCollection = db.collection("CV")
           
           // Perform the query asynchronously
           let querySnapshot = try await cvCollection
               .whereField("userID", isEqualTo: userID)
               .getDocuments()
           
           // Create an array to hold CV names
           var cvNames: [String] = []
           
           // Iterate over the documents and extract the CVName
           for document in querySnapshot.documents {
               if let cvName = document["CVName"] as? String {
                   cvNames.append(cvName)
               }
           }
           
           // Return the array of CV names
           return cvNames
    }
    
    func addCourseCertification(certification: CourseCertification, completion: @escaping (Result<Void, Error>) -> Void) {
            // Reference to the "courseCertifications" collection
            let certificationsRef = db.collection("courseCertifications")
            
            // Query to check if the user already has a certificate for the course
            certificationsRef
                .whereField("userId", isEqualTo: certification.userId)
                .whereField("courseId", isEqualTo: certification.courseId)
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        completion(.failure(error)) // Handle the error
                        return
                    }
                    
                    // If documents exist, the user already has the certification
                    if let documents = querySnapshot?.documents, !documents.isEmpty {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Certification already exists."])))
                        return
                    }
                    
                    // If no documents exist, add the new certification
                    let certificationData: [String: Any] = [
                        "title": certification.title,
                        "courseId": certification.courseId,
                        "date": Timestamp(date: certification.date), // Convert Date to Firebase Timestamp
                        "userId": certification.userId, // Add userId field
                        "score": certification.score // Add score field
                    ]
                    
                    certificationsRef.addDocument(data: certificationData) { error in
                        if let error = error {
                            completion(.failure(error)) // Handle the error
                        } else {
                            completion(.success(())) // Successfully added
                        }
                    }
                }
        }
}


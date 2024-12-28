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
            course.courseContent = try await content
           course.courseComments = try await comments
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
        guard let userId = data["user_id"] as? String,
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
    
    func fetchTheUserCVs(forUserID userID: String) async throws -> [CVInfo] {
        let db = Firestore.firestore()
        
        // Reference to the "CV" collection
        let cvCollection = db.collection("CV")
        
        // Perform the query asynchronously
        let querySnapshot = try await cvCollection
            .whereField("userID", isEqualTo: userID)
            .getDocuments()
        // Create an array to hold CV information
        var cvs: [CVInfo] = []
        
        // Iterate over the documents and extract the CV ID and Name
        for document in querySnapshot.documents {
            let id = document.documentID
            if let name = document["cvName"] as? String {
                cvs.append(CVInfo(id: id, name: name))
            }
        }
        // Return the array of CV information
        return cvs
    }
    
    func addComment(courseId: String, commentText: String, userId: String, rated: Int, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()

        // Reference to the course document
        let courseDocRef = db.collection("OnlineCourses").document(courseId)

        // Check if the course document exists
        courseDocRef.getDocument { (document, error) in
            if let error = error {
                print("Error checking course document: \(error.localizedDescription)")
                completion(error)
                return
            }

            guard let document = document, document.exists else {
                print("Course document does not exist.")
                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Course not found"]))
                return
            }

            // Create a new comment dictionary
            let newComment: [String: Any] = [
                "user_id": userId,
                "commenttext": commentText,
                "rated": rated,
                "timestamp": FieldValue.serverTimestamp() // Automatically set the timestamp
            ]

            // Reference to the courseComments sub-collection within the specified course document
            courseDocRef.collection("courseComments").addDocument(data: newComment) { error in
                if let error = error {
                    print("Error adding comment: \(error.localizedDescription)")
                    completion(error)
                } else {
                    print("Comment added successfully!")
                    completion(nil)
                }
            }
        }
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
                    
//                    // If documents exist, the user already has the certification
//                    if let documents = querySnapshot?.documents, !documents.isEmpty {
//                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Certification already exists."])))
//                        return
//                    }
//                    
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
    
    func fetchUsername(userId: String) async throws -> String {
        let db = Firestore.firestore()

        // Reference to the User collection
        let documentSnapshot = try await db.collection("User").document(userId).getDocument()

        // Check if the document exists
        guard documentSnapshot.exists else {
            throw NSError(domain: "FetchError", code: 1, userInfo: [NSLocalizedDescriptionKey: "User document does not exist"])
        }

        // Extract the username from the document
        if let username = documentSnapshot.get("username") as? String {
            return username
        } else {
            throw NSError(domain: "FetchError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Username not found"])
        }
    }
    
    // Function to fetch certifications for a CV based on cvID
        func fetchCertifications(forCVID cvID: String) async throws -> [[String: Any]] {
            let db = Firestore.firestore()
            
            // Reference to the CV document in Firestore
            let cvDocumentRef = db.collection("CV").document(cvID)
            
            // Fetch the CV document
            let document = try await cvDocumentRef.getDocument()
            
            if let certificationsArray = document.data()?["certifications"] as? [[String: Any]] {
                return certificationsArray
            } else {
                throw NSError(domain: "CourseManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "Certifications not found"])
            }
        }

        // Function to update certifications in Firestore
        func updateCertifications(forCVID cvID: String, certifications: [[String: Any]], completion: @escaping (Error?) -> Void) {
            let db = Firestore.firestore()
            let cvDocumentRef = db.collection("CV").document(cvID)
            
            cvDocumentRef.updateData([
                "certifications": certifications
            ]) { error in
                completion(error)
            }
        }
    
    func fetchCertifications(for userId: String) async throws -> [CourseCertification] {
        let db = Firestore.firestore()

        do {
            // Fetch all certifications for the specified user
            let querySnapshot = try await db.collection("courseCertifications")
                .whereField("userId", isEqualTo: userId)
                .getDocuments()

            // Process the documents using a task group
            return try await withThrowingTaskGroup(of: CourseCertification?.self) { group in
                for document in querySnapshot.documents {
                    group.addTask {
                        let data = document.data()

                        // Safely unwrap values and log errors if data is invalid
                        guard let title = data["title"] as? String,
                              let courseId = data["courseId"] as? String,
                              let timestamp = data["date"] as? Timestamp,
                              let score = data["score"] as? Int else {
                            print("Invalid data for document: \(document.documentID), data: \(data)")
                            return nil // Skip invalid data
                        }

                        // Convert Firestore timestamp to Date
                        let date = timestamp.dateValue()

                        // Create and return a valid CourseCertification object
                        return CourseCertification(title: title, courseId: courseId, date: date, userId: userId, score: score)
                    }
                }

                // Collect results, skipping nil values
                var certifications = [CourseCertification]()
                for try await certification in group {
                    if let validCertification = certification {
                        certifications.append(validCertification)
                    }
                }
                return certifications
            }
        } catch {
            // Handle Firestore errors or any unexpected issues
            print("Error fetching certifications: \(error.localizedDescription)")
            throw error
        }
    }
    
    
}

func renameSubCollection(oldPath: String, newPath: String) {
    let db = Firestore.firestore()
    
    // Reference to the old and new sub-collections
    let oldSubCollectionRef = db.collection(oldPath)
    let newSubCollectionRef = db.collection(newPath)
    
    // Get all documents from the old sub-collection
    oldSubCollectionRef.getDocuments { (snapshot, error) in
        if let error = error {
            print("Error getting documents: \(error)")
            return
        }
        
        guard let documents = snapshot?.documents else { return }
        
        // Create a batch for writing
        let batch = db.batch()
        
        for document in documents {
            let newDocRef = newSubCollectionRef.document(document.documentID) // Keep the same document ID
            batch.setData(document.data(), forDocument: newDocRef)
        }
        
        // Commit the batch to copy documents
        batch.commit { (error) in
            if let error = error {
                print("Error copying documents: \(error)")
            } else {
                print("Documents copied successfully!")
                // Now delete the old sub-collection
                deleteOldSubCollection(collectionRef: oldSubCollectionRef)
            }
        }
    }
}

func deleteOldSubCollection(collectionRef: CollectionReference) {
    collectionRef.getDocuments { (snapshot, error) in
        if let error = error {
            print("Error getting documents for deletion: \(error)")
            return
        }
        
        guard let documents = snapshot?.documents else { return }
        
        // Create a batch for deleting
        let batch = Firestore.firestore().batch()
        
        for document in documents {
            batch.deleteDocument(document.reference)
        }
        
        // Commit the batch to delete documents
        batch.commit { (error) in
            if let error = error {
                print("Error deleting old sub-collection: \(error)")
            } else {
                print("Old sub-collection deleted successfully!")
            }
        }
    }
}

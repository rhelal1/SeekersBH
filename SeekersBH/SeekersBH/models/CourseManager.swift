import FirebaseFirestore

class CourseManager {
    
    static let share = CourseManager()

    private let db = Firestore.firestore()

    // Define the async method to fetch all courses along with related collections
    func fetchAllCourses() async throws -> [Course] {
        let snapshot = try await db.collection("courses").getDocuments()
        
        var courses = [Course]()
        
        // Iterate through all documents and fetch associated data (comments, content, and questions)
        for document in snapshot.documents {
            let course = try await self.fetchCourseDetails(courseId: document.documentID)

            courses.append(course)
        }
        
        return courses
    }

    private func fetchCourseDetails(courseId: String) async throws -> Course {
        let courseRef = db.collection("courses").document(courseId)
        
        // Fetch the course document
        let document = try await courseRef.getDocument()
        
        guard let data = document.data(),
              let course = parseCourseData(data: data) else {
            throw NSError(domain: "CourseError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Course not found or failed to parse data"])
        }
        
        // Fetch related collections: comments, content, and questions
        let courseComments = try await fetchComments(for: courseRef)
        let courseContent = try await fetchContent(for: courseRef)
        let courseQuestions = try await fetchQuestions(for: courseRef)
        
        var courseWithDetails = course
        courseWithDetails.courseComments = courseComments
        courseWithDetails.courseContent = courseContent
        courseWithDetails.courseQuestions = courseQuestions
        
        return courseWithDetails
    }
    
    private func fetchComments(for courseRef: DocumentReference) async throws -> [CourseComments] {
        let snapshot = try await courseRef.collection("CourseComments").getDocuments()
        var comments = [CourseComments]()
        
        for document in snapshot.documents {
            if let comment = parseCourseCommentData(data: document.data()) {
                comments.append(comment)
            }
        }
        
        return comments
    }

    private func fetchContent(for courseRef: DocumentReference) async throws -> [CourseContent] {
        let snapshot = try await courseRef.collection("CourseContent").getDocuments()
        var content = [CourseContent]()
        
        for document in snapshot.documents {
            if let courseContent = parseCourseContentData(data: document.data()) {
                content.append(courseContent)
            }
        }
        
        return content
    }
    
    private func fetchQuestions(for courseRef: DocumentReference) async throws -> [Question] {
        let snapshot = try await courseRef.collection("CourseQuestions").getDocuments()
        var questions = [Question]()
        
        for document in snapshot.documents {
            if let question = parseQuestionData(data: document.data()) {
                questions.append(question)
            }
        }
        
        return questions
    }

    // Helper methods for parsing the data into model objects

    private func parseCourseData(data: [String: Any]) -> Course? {
        guard let id = data["id"] as? String,
              let title = data["title"] as? String,
              let rating = data["rating"] as? Double,
              let description = data["description"] as? String,
              let instructor = data["instructor"] as? String,
              let prerequisites = data["prerequisites"] as? String,
              let outcomes = data["outcomes"] as? String,
              let categoryRaw = data["category"] as? String,
              let category = CourseCategory(rawValue: categoryRaw) else {
            return nil
        }

        return Course(id: id, title: title, rating: rating, description: description,
                      instructor: instructor, prerequisites: prerequisites, outcomes: outcomes,
                      category: category, courseComments: [], courseContent: [], courseQuestions: [])
    }

    private func parseCourseCommentData(data: [String: Any]) -> CourseComments? {
        guard let userId = data["userId"] as? Int,
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

    private func parseQuestionData(data: [String: Any]) -> Question? {
        guard let questionTxt = data["questionTxt"] as? String,
              let options = data["options"] as? [String],
              let correctAnswer = data["correctAnswer"] as? String,
              let points = data["points"] as? Int else {
            return nil
        }
        return Question(questionTxt: questionTxt, options: options, correctAnswer: correctAnswer, points: points)
    }
}


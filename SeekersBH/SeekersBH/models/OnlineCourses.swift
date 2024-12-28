import Foundation

struct Course {
    var id: String // The course ID
    var title: String
    var rating: Double
    var description: String
    var instructor: String
    var prerequisites: String
    var outcomes: String
    var category: CourseCategory
    var pictureUrl: String  // Add pictureUrl here
    var courseComments: [CourseComments]
    var courseContent: [CourseContent]
    var courseQuestions: [Question]
}

struct CourseComments {
    var userId : String
    var commenttext : String
    var rated : Int
}

struct CourseContent {
    var title : String
    var duration : Int
    var description : String
    var videoUrl : String
}

struct Question {
    var questionTxt : String
    var options : [String]
    var correctAnswer : String
    var selectedAnswer : Int = -1
    var points : Int
}

enum CourseCategory: String, Codable {
    case technology
    case business
    case economics
}

struct CourseCertification {
    var title: String
    var courseId: String
    var date: Date
    var userId: String
    var score: Int // Add score to store the user's achievement
}

struct CVInfo {
    let id: String
    let name: String
}

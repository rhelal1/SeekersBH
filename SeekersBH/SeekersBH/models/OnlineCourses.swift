import Foundation

struct Course {
    var title : String
    var rating : Double
    var description : String
    var instructor : String
    var prerequisites : String
    var outcomes : String
    
    var category : CourseCategory
    
    var courseComments : [CourseComments]
    var courseContent : [CourseContent]
    var courseQuestions : [question]
}

struct CourseComments {
    var userId : Int
    var username : String
    var commenttext : String
    var rated : Int
}

struct CourseContent {
    var title : String
    var duration : Int
    var description : String
    var videoUrl : String
}

struct question {
    var questionTxt : String
    var option1 : String
    var option2 : String
    var option3 : String
    var option4 : String
    var correctAnswer : String
    var points : Int
}

enum CourseCategory: String, Codable {
    case technology
    case business
    case science
    case economics
    case health
}

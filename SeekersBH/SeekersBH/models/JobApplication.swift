import Foundation

struct JobApplication {
    var fullName : String
    var email : String
    var phoneNumber : String
    var address : String?
    
    var workExperince : WorkExperince?
    var education : Education?

    var likedInURL : String?
    var protofolioURL : String?
    var aboutMe : String?
    
    var educations : [Degree : Insinuation]?
    var skills : [Skill]?
    var certifications : [Certification]?
    var projectSecions : [Project]?
    var qualifications : Qualification?
    var reference : Reference?
    var additionalQuestions : [String : String]?
    
    //var uploadCV : CV
    var uploadCV : String?
    //var coverLetter : Data
}

struct WorkExperince {
    var jobTitle : String
    var companyName : String
    var employmentDate : Date
    var jobResponsibilites : String?
}

struct Education {
    //var dgree : Degree
    var dgree : String
    //var insinuation : Insinuation
    var insinuation : String
    var graduationDate : Date
}

struct Qualification {
    //var skill : String
    var skill : [String]?
    //var certifications : [Certification]
    var certifications : [String]?
    //var languages : String
    var languages : [String]?
}

struct Reference {
    var name : String
    var contactDetails : String
}
//hello hello heloo

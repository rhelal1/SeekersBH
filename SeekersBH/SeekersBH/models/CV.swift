import Foundation

struct CV {
    var fullName : String
    var email : String
    var phoneNumber : String
    var likedInURL : String
    var protofolioURL : String
    var aboutMe : String
    var educations : [Degree : Insinuation]
    var skills : String
    var otherSkills: String
    var certifications : [Certification]
    var otherCertification : String
    var projectSecions : [Project]
    var otherProjects : String
    var highestDegree: String
    var university: String
}


enum Degree : Hashable {
    
}

enum Insinuation {
    
}

struct Certification {
    var name : String
    var DateObtained : Date
    var IssuingOrganization : String
}

struct Project {
    var name : String
    var overview : String
    var resource : String
}

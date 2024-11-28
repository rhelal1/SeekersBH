import Foundation

struct CV {
    var fullName : String
    var email : String
    var phoneNumber : String
    var likedInURL : String
    var protofolioURL : String
    var aboutMe : String
    var educations : [Degree : Insinuation]
    var skills : [Skill]
    var certifications : [Certification]
    var projectSecions : [Project]
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

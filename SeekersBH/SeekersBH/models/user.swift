import Foundation

struct User {
    var id : Int
    var email : String
    var firstName : String
    var lastName : String
    var userName : String
    var dateOfBirth : Date
    var location : Location
    
    var mostResentJobTitle : String
    var mostResentCompany : String
    var password : String
    
    var listOfUserInterset : [Interest]
    var listOfSkills : [Skill]
    
//    var CVs : [CV]
//    var following : [User]
//    var followers : [User]
//    var jobApplications : [JobApplication]
}

enum Location {
    
}

enum Interest {
    
}

enum Skill {
    
}

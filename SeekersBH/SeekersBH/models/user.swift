import Foundation

struct User {
    
    static var loggedInUser = "check@gmail.com"
    static var loggedInID = "4iW3tfx0ca5bfzpXpD83"

    static var loggedInUsername = ""
    var id : String
    var email : String
    var firstName : String
    var lastName : String
    var userName : String
    var dateOfBirth : Date
    var location : Location
    
    var mostResentJobTitle : String
    var mostResentCompany : String
    var password : String
    var isHidden : Bool

//    var listOfUserInterset : [Interest]
//    var listOfSkills : [Skill]
    
//    var CVs : [CV]
//    var following : [User]
//    var followers : [User]
//    var jobApplications : [JobApplication]
}

enum Location {
    case city(String)
}

enum Interest {
    
}

enum Skill {
    
}

struct Employer {
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
}

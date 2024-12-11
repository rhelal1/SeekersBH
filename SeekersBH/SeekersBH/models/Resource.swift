import Foundation

struct Article {
    var title : String
    var author : String
    var yearOfPublication : Int
    var publisher : String
    var DOI : String
    
    var description : String
    var shortDescription : String
    var url : String
    var views : Int
}

struct Webinar {
    var title : String
    var speaker : String
    var date : Date
    var timeZone : TimeZone //not sure
    var picture : String
    
    var description : String
    var url : String
    var views : Int
}

struct Video {
    var title : String
    var speaker : String
    var channel : String
    var duration : Int // Duration in seconds
    var picture : String
    
    var description : String
    var url : String
    var views : Int
}

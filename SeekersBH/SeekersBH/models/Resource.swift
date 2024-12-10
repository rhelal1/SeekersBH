import Foundation

struct Article {
    var title : String
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
    var time : TimeZone //not sure
    var picture : String
    
    var description : String
    var shortDescription : String
    var url : String
    var views : Int
}

struct Videos {
    var title : String
    var speaker : String
    var channel : String
    var Duration : Int
    var picture : String
    
    var description : String
    var shortDescription : String
    var url : String
    var views : Int
}

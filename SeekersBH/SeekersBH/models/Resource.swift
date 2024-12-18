import Foundation

protocol Resource : Codable {
    var title: String { get }
    var description: String { get }
    var url: String { get }
    var views: Int { get }
}

enum ResourceTypes: String, Codable {
    case article
    case webinar
    case video
}

struct Article : Resource {
    var id : String
    var title : String
    var author : String
    var yearOfPublication : Int
    var publisher : String
    var DOI : String
    
    var description : String
    var url : String
    var views : Int
}

struct Webinar : Resource{
    var title : String
    var speaker : String
    var date : Date
    var timeZone : TimeZone //not sure
    var picture : String
    
    var description : String
    var url : String
    var views : Int
}

struct Video : Resource {
    var title : String
    var speaker : String
    var channel : String
    var duration : Int // Duration in seconds
    var picture : String
    
    var description : String
    var url : String
    var views : Int
}

struct SavedResource {
    var resource: Resource
    var type : ResourceTypes
}



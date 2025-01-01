import Foundation

protocol Resource : Codable {
    var id: String { get }
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
    var isHidden : Bool = false
    // Mapping Firestore's 'year_of_publication' to 'yearOfPublication'
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case yearOfPublication = "year_of_publication"  // Firestore field
        case publisher
        case DOI
        case description
        case url
        case views
    }
}

struct Webinar : Resource{
    var id : String
    var title : String
    var speaker : String
    var date : Date
    var timeZone : String 
    var picture : String
    var isHidden : Bool = false
    var description : String
    var url : String
    var views : Int
    
    // Mapping Firestore's fields to Swift properties
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case speaker
        case date
        case timeZone 
        case picture
        case description
        case url
        case views
    }
}

struct Video : Resource {
    var id : String
    var title : String
    var speaker : String
    var channel : String
    var duration : Int // Duration in mintues
    var picture : String
    var isHidden : Bool = false
    var description : String
    var url : String
    var views : Int
    
    // Mapping Firestore's fields to Swift properties
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case speaker
        case channel
        case duration
        case picture
        case description
        case url
        case views
    }
}

struct SavedResource {
    var resource: Resource
    var type : ResourceTypes
}



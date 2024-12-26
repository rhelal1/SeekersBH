import Foundation
import FirebaseFirestore

// Define the AppUser struct in a common location
struct AppUser {
    var id: String
    var email: String
    var firstName: String
    var lastName: String
    var userName: String
    var dateOfBirth: Date
    var location: String
    var mostRecentJobTitle: String
    var mostRecentCompany: String
    var password: String
    var role: String // New field to store user role
    var selectedInterests: [String] // Array to store selected interests
    
    func toDictionary() -> [String: Any] {
        let timestamp = Timestamp(date: dateOfBirth) // Convert Date to Firestore Timestamp
        
        return [
            "id": id,
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "userName": userName,
            "dateOfBirth": timestamp, // Save as Firestore Timestamp
            "location": location,
            "mostRecentJobTitle": mostRecentJobTitle,
            "mostRecentCompany": mostRecentCompany,
            "password": password, // Note: Avoid saving plain passwords in production
            "role": role, // Include the role when saving to Firestore
            "selectedInterests": selectedInterests // Include selected interests
        ]
    }
}

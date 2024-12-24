import Foundation
import FirebaseFirestore

final class ResourceManager {
    
    static let share = ResourceManager()
    private init() {}
    
    func fetchArticles() async throws -> [Article] {
        let snapshot = try await Firestore.firestore().collection("Article").getDocuments()
        
        let articles: [Article] = try snapshot.documents.compactMap { document in
            guard
                let id = document["id"] as? String,
                let title = document["title"] as? String,
                let author = document["author"] as? String,
                let yearOfPublication = document["year_of_publication"] as? Int,
                let publisher = document["publisher"] as? String,
                let DOI = document["DOI"] as? String,
                let description = document["description"] as? String,
                let url = document["url"] as? String,
                let views = document["views"] as? Int
            else {
                throw URLError(.badServerResponse)
            }
            
            return Article(
                id : id,
                title: title,
                author: author,
                yearOfPublication: yearOfPublication,
                publisher: publisher,
                DOI: DOI,
                description: description,
                url: url,
                views: views
            )
        }
        
        return articles
    }
    
    func incrementViews(forArticleId articleId: String, completion: @escaping (Error?) -> Void) {
        let articleRef = Firestore.firestore().collection("Article").document(articleId)
        
        // Perform the increment operation
        articleRef.updateData([
            "views": FieldValue.increment(Int64(1))
        ]) { error in
            if let error = error {
                print("Error incrementing views: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Views incremented successfully")
                completion(nil)
            }
        }
    }
    
    func fetchWebinars() async throws -> [Webinar] {
        let snapshot = try await Firestore.firestore().collection("Webinars").getDocuments()
        
        // Use compactMap to handle documents, skipping those that can't be parsed
        let webinars: [Webinar] = snapshot.documents.compactMap { document in
            // Try to extract the fields safely
            guard
                let id = document["id"] as? String,
                let title = document["title"] as? String,
                let speaker = document["speaker"] as? String,
                let timestamp = document["date"] as? Timestamp,
                let timeZone = document["timeZone"] as? String,
                let picture = document["picture"] as? String,
                let description = document["description"] as? String,
                let url = document["url"] as? String,
                let views = document["views"] as? Int
            else {
                // Skip the document if it doesn't contain all required fields
                print("Skipping document with missing or invalid data")
                return nil  // Returning nil skips this document from the final list
            }
            
            // Convert the timestamp to a Date object
            let date = timestamp.dateValue()
            
            // Return the Webinar object if all fields are valid
            return Webinar(
                id: id,
                title: title,
                speaker: speaker,
                date: date,
                timeZone: timeZone,
                picture: picture,
                description: description,
                url: url,
                views: views
            )
        }
        
        return webinars
    }

    func fetchVideos() async throws -> [Video] {
        let snapshot = try await Firestore.firestore().collection("Videos").getDocuments()
        
        // Use compactMap to handle documents, skipping those that can't be parsed
        let videos: [Video] = snapshot.documents.compactMap { document in
            // Try to extract the fields safely
            guard
                let id = document["id"] as? String,
                let title = document["title"] as? String,
                let speaker = document["speaker"] as? String,
                let channel = document["channel"] as? String,
                let duration = document["duration"] as? Int,
                let picture = document["picture"] as? String,
                let description = document["description"] as? String,
                let url = document["url"] as? String,
                let views = document["views"] as? Int
            else {
                // Skip the document if it doesn't contain all required fields
                print("Skipping document with missing or invalid data")
                return nil  // Returning nil skips this document from the final list
            }
            
            // Return the Webinar object if all fields are valid
            return Video(
                id: id,
                title: title,
                
                speaker: speaker,
                channel: channel,
                duration: duration,
                
                picture: picture,
                description: description,
                url: url,
                views: views
            )
        }
        
        return videos
    }
    
    
    func insertWebinars(webinar : Webinar) {
        let db = Firestore.firestore()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Specify the expected format
        
            let docRef = db.collection("Webinars").document() // Create a reference with an auto-generated ID
                        
            // Prepare the data for Firestore
            let webinarData: [String: Any] = [
                "id": docRef.documentID,             // Set the `id` field in the webinar object
                "title": webinar.title,
                "speaker": webinar.speaker,
                "date": Timestamp(date: webinar.date),
                "timeZone": webinar.timeZone,
                "picture": webinar.picture,
                "description": webinar.description,
                "url": webinar.url,
                "views": 0
            ]
            
            // Save the data to Firestore
            docRef.setData(webinarData) { error in
                if let error = error {
                    print("Error adding webinar: \(error)")
                } else {
                    print("Webinar added successfully with ID: \(webinar.id)")
                }
            }
    }
    
    func insertVideos(video : Video) {
        let db = Firestore.firestore()
    
            let docRef = db.collection("Videos").document() // Create a reference with an auto-generated ID
            
            // Convert the Video struct to a dictionary for Firestore
            let videoData: [String: Any] = [
                "id": docRef.documentID,
                "title": video.title,
                "speaker": video.speaker,
                "channel": video.channel,
                "duration": video.duration,
                "picture": video.picture,
                "description": video.description,
                "url": video.url,
                "views": 0
            ]
            
            // Save the data to Firestore
            docRef.setData(videoData) { error in
                if let error = error {
                    print("Error adding webinar: \(error)")
                } else {
                    print("Webinar added successfully with ID: \(video.id)")
                }
            }
    }
    
    
    func saveResourceToFirebase(userID: String, resourceId: String, resourceType: ResourceTypes, viewController: UIViewController) {
        
        // Check if the resource is already saved
        isResourceAlreadySaved(userID: userID, resourceType: resourceType, resourceID: resourceId) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let isSaved):
                        if isSaved {
                            self!.showAlert(title: "Resource Status", message: "This resource is already saved!", in : viewController)
                        } else {
                            let db = Firestore.firestore()
                            
                            // Prepare the data
                            let data: [String: Any] = [
                                "user_id": userID,
                                "resource_type": resourceType.rawValue, // Resource type as a string
                                "resource_id": resourceId
                            ]
                            
                            // Insert into Firestore
                            db.collection("userResources").addDocument(data: data)
                            
                            self!.showAlert(title: "Resource Status", message: "Resource saved Successfully!", in : viewController)
                        }
                    case .failure(let error):
                        self!.showAlert(title: "Error", message: "Failed to check resource status: \(error.localizedDescription)", in : viewController)
                    }
                }
            }
    }
    
    // Helper function to show alert in the view controller
         func showAlert(title: String, message: String, in viewController: UIViewController) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(alert, animated: true, completion: nil)
        }
    
    func isResourceAlreadySaved(userID: String, resourceType: ResourceTypes, resourceID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("userResources")
            .whereField("user_id", isEqualTo: userID)
            .whereField("resource_type", isEqualTo: resourceType.rawValue)
            .whereField("resource_id", isEqualTo: resourceID)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                    completion(.success(true)) // Resource exists
                } else {
                    completion(.success(false)) // Resource does not exist
                }
            }
    }
    

}


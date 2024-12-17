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
                print("check1")
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

}

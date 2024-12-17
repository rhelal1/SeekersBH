import FirebaseFirestore

// FirebaseManager.swift
class FirebaseManager {
    
    // Singleton instance
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    private init() {
        // Private init to prevent multiple instances.
    }
    
    func addDocumentToCollection(collectionName: String, data: [String: Any]) {
        db.collection(collectionName).addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added successfully.")
            }
        }
    }
    
    func fetchCollectionData(collectionName: String) {
        db.collection(collectionName).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
            } else {
                for document in snapshot!.documents {
                    print("\(document.documentID): \(document.data())")
                }
            }
        }
    }
    
    func fetchResources(ofType type: ResourceTypes, completion: @escaping ([Resource]?, Error?) -> Void) {
        FirebaseManager.shared.db.collection(type.rawValue).getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion([], nil)
                return
            }
            
            do {
                var resources: [Resource] = []
                for document in documents {
                    let data = document.data()
                    
                    switch type {
                    case .article:
                        let article: Article = try Article.fromDictionary(data)
                        resources.append(article)
                    case .webinar:
                        let webinar: Webinar = try Webinar.fromDictionary(data)
                        resources.append(webinar)
                    case .video:
                        let video: Video = try Video.fromDictionary(data)
                        resources.append(video)
                    }
                }
                completion(resources, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
    
}

extension Decodable {
    static func fromDictionary<T: Decodable>(_ dictionary: [String: Any]) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        let decodedObject = try JSONDecoder().decode(T.self, from: data)
        return decodedObject
    }
}



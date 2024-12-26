import FirebaseFirestore

class FirebaseManager {
    
    // Singleton instance
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    private init() {}
    
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
    
    func updateDocument(collectionName: String, documentId: String, data: [String: Any], completion: ((Error?) -> Void)? = nil) {
        db.collection(collectionName).document(documentId).updateData(data) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document updated successfully.")
            }
            completion?(error)
        }
    }
    
    func addDocumentToCollection_qassim(collectionName: String, data: [String: Any], completion: ((Error?) -> Void)? = nil) {
        db.collection(collectionName).addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
                completion?(error)
            } else {
                print("Document added successfully.")
                completion?(nil)
            }
        }
    }
    
    func deleteDocument(collectionName: String, documentId: String, completion: ((Error?) -> Void)? = nil) {
        db.collection(collectionName).document(documentId).delete() { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
                completion?(error)
            } else {
                print("Document successfully deleted.")
                completion?(nil)
            }
        }
    }
}

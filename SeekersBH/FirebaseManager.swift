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
}

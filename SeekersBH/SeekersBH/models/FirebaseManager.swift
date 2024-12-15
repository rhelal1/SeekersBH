import Foundation
import Firebase

//class FirebaseManager {
//    
//    // Singleton instance
//    static let shared = FirebaseManager()
//    
////    private let db = Firestore.firestore()
//    
//    private init() {
//        // Private init to prevent multiple instances.
//    }
//    
//    // MARK: - Save User Information
//    func saveUserInfo(userId: String, name: String, email: String, phone: String, completion: @escaping (Bool) -> Void) {
////        let userRef = db.collection("users").document(userId)
//        
//        let userData: [String: Any] = [
//            "name": name,
//            "email": email,
//            "phone": phone,
////            "createdAt": FieldValue.serverTimestamp()
//        ]
//        
////        userRef.setData(userData) { error in
//            if let error = error {
//                print("Error saving user info: \(error.localizedDescription)")
//                completion(false)
//            } else {
//                print("User info saved successfully.")
//                completion(true)
//            }
//        }
//    }
//    
//    // MARK: - Save Job Application
//    func saveJobApplication(userId: String, jobTitle: String, company: String, resumeURL: String, completion: @escaping (Bool) -> Void) {
//        let applicationsRef = db.collection("jobApplications").document(userId).collection("applications")
//        
//        let jobData: [String: Any] = [
//            "jobTitle": jobTitle,
//            "company": company,
//            "resumeURL": resumeURL,
//            "appliedAt": FieldValue.serverTimestamp()
//        ]
//        
//        applicationsRef.addDocument(data: jobData) { error in
//            if let error = error {
//                print("Error saving job application: \(error.localizedDescription)")
//                completion(false)
//            } else {
//                print("Job application saved successfully.")
//                completion(true)
//            }
//        }
//    }
//    
//    // MARK: - Fetch User Info
//    func fetchUserInfo(userId: String, completion: @escaping (UserInfo?) -> Void) {
//        let userRef = db.collection("users").document(userId)
//        
//        userRef.getDocument { (document, error) in
//            if let error = error {
//                print("Error fetching user info: \(error.localizedDescription)")
//                completion(nil)
//            } else if let document = document, document.exists {
//                do {
//                    let userInfo = try document.data(as: UserInfo.self)
//                    completion(userInfo)
//                } catch {
//                    print("Error decoding user info: \(error)")
//                    completion(nil)
//                }
//            } else {
//                print("User does not exist.")
//                completion(nil)
//            }
//        }
//    }
//    
//    // MARK: - Fetch Job Applications
//    func fetchJobApplications(userId: String, completion: @escaping ([JobApplication]?) -> Void) {
//        let applicationsRef = db.collection("jobApplications").document(userId).collection("applications")
//        
//        applicationsRef.getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print("Error fetching job applications: \(error.localizedDescription)")
//                completion(nil)
//            } else {
//                var applications: [JobApplication] = []
//                for document in querySnapshot!.documents {
//                    do {
//                        let application = try document.data(as: JobApplication.self)
//                        applications.append(application)
//                    } catch {
//                        print("Error decoding job application: \(error)")
//                    }
//                }
//                completion(applications)
//            }
//        }
//    }
//}
//
//

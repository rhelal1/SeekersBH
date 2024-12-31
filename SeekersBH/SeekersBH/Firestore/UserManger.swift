//
//  UserManger.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//

import Foundation
import FirebaseFirestore

class UserManger {
    static let shared = UserManger()
    private init() {}
    
    let db = Firestore.firestore()
    
    func fetchAllUsers(completion: @escaping ([User]) -> Void) {
        db.collection("User").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No users found")
                completion([])
                return
            }
            
            var users: [User] = []
            
            for document in documents {
                let data = document.data()
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM yyyy 'at' HH:mm:ss z"
                
                let dateOfBirth = dateFormatter.date(from: data["dateOfBirth"] as? String ?? "") ?? Date()
                
                let user = User(
                    id: document.documentID,
                    email: data["email"] as? String ?? "",
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    userName: data["username"] as? String ?? "",
                    dateOfBirth: dateOfBirth,
                    location: Location.city(data["location"] as? String ?? ""),
                    mostResentJobTitle: data["recentJob"] as? String ?? "",
                    mostResentCompany: data["recentCompany"] as? String ?? "",
                    password: data["password"] as? String ?? "",
                    isHidden: data["isHidden"] as? Bool ?? false
                )
                users.append(user)
            }
            completion(users)
        }
    }
    
    func fetchUserInfo(userID: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        db.collection("User").document(userID).getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                print("Error fetching user info: \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists else {
                completion(nil, NSError(domain: "UserProfileError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                return
            }
            completion(document.data(), nil)
        }
    }
    
    func fetchUserSkills(userID: String, completion: @escaping ([String], Error?) -> Void) {
        var skills: [String] = []
        db.collection("Skill").whereField("userID", isEqualTo: userID).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion([], error)
                return
            }
            print(userID)
            for doc in querySnapshot?.documents ?? [] {
                       for i in 1...4 {
                           if let skill = doc["skill\(i)"] as? String, !skill.isEmpty {
                               skills.append(skill)
                           }
                       }
                   }
            completion(skills, nil)
        }
    }
    
    func fetchUserInterests(userID: String, completion: @escaping ([String], Error?) -> Void) {
        var interests: [String] = []
        db.collection("Interest").whereField("userID", isEqualTo: userID).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion([], error)
                return
            }
            for doc in querySnapshot?.documents ?? [] {
                       for i in 1...4 {
                           if let interest = doc["interest\(i)"] as? String, !interest.isEmpty {
                               interests.append(interest)
                           }
                       }
                   }
            completion(interests, nil)
        }
    }
    
    func fetchUserConnections(userID: String, completion: @escaping ([String], [String], Error?) -> Void) {
        db.collection("userConnections2")
            .whereField("userID", isEqualTo: userID)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion([], [], error)
                    return
                }
                
                guard let document = querySnapshot?.documents.first else {
                    completion([], [], nil)
                    return
                }
                
                do {
                    let userRelations = try document.data(as: UserRelations.self)
                    completion(userRelations.followers, userRelations.followings, nil)
                } catch {
                    completion([], [], error)
                }
            }
    }

//    func toggleFollowStatus(userID: String, followerID: String, completion: @escaping (Bool, Error?) -> Void) {
//            let userQuery = db.collection("userConnections2").whereField("userID", isEqualTo: userID)
//            
//            userQuery.getDocuments { snapshot, error in
//                guard let snapshot = snapshot, !snapshot.isEmpty, let document = snapshot.documents.first else {
//                    completion(false, error ?? NSError(domain: "UserNotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "User document not found"]))
//                    return
//                }
//                
//                let userDocRef = self.db.collection("userConnections2").document(document.documentID)
//                
//                self.db.runTransaction({ (transaction, errorPointer) -> Any? in
//                    let userDocument: DocumentSnapshot
//                    do {
//                        try userDocument = transaction.getDocument(userDocRef)
//                    } catch let fetchError as NSError {
//                        errorPointer?.pointee = fetchError
//                        return nil
//                    }
//                    
//                    var followers = userDocument.data()?["followers"] as? [String] ?? []
//                    
//                    if !followers.contains(followerID) {
//                        // Add follower
//                        followers.append(followerID)
//                    } else {
//                        // Remove follower
//                        followers.removeAll { $0 == followerID }
//                    }
//                    transaction.updateData(["followers": followers], forDocument: userDocRef)
//                    return nil
//                }) { (_, error) in
//                    if let error = error {
//                        completion(false, error)
//                    } else {
//                        completion(true, nil)
//                    }
//                }
//            }
//        }
    func toggleFollowStatus(userID: String, followerID: String, completion: @escaping (Bool, Bool, Error?) -> Void) {
        let userQuery = db.collection("userConnections2").whereField("userID", isEqualTo: userID)
        
        userQuery.getDocuments { snapshot, error in
            guard let snapshot = snapshot, !snapshot.isEmpty, let document = snapshot.documents.first else {
                completion(false, false, error ?? NSError(domain: "UserNotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "User document not found"]))
                return
            }
            
            let userDocRef = self.db.collection("userConnections2").document(document.documentID)
            
            self.db.runTransaction({ (transaction, errorPointer) -> Any? in
                let userDocument: DocumentSnapshot
                do {
                    try userDocument = transaction.getDocument(userDocRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
                
                var followers = userDocument.data()?["followers"] as? [String] ?? []
                var isFollowing = false
                
                if followers.contains(followerID) {
                    // Remove follower
                    followers.removeAll { $0 == followerID }
                    isFollowing = false
                } else {
                    // Add follower
                    followers.append(followerID)
                    isFollowing = true
                }
                transaction.updateData(["followers": followers], forDocument: userDocRef)
                return isFollowing
            }) { (isFollowing, error) in
                if let error = error {
                    completion(false, false, error)
                } else if let isFollowing = isFollowing as? Bool {
                    completion(true, isFollowing, nil)
                }
            }
        }
    }

}


struct UserRelations: Codable {
    let userID: String
    let followers: [String]
    let followings: [String]
}

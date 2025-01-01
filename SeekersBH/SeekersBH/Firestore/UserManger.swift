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
            for doc in querySnapshot?.documents ?? [] {
                if let skill = doc["skill1"] as? String, !skill.isEmpty {
                    skills.append(skill)
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
                if let interest = doc["interest1"] as? String, !interest.isEmpty {
                    interests.append(interest)
                }
            }
            completion(interests, nil)
        }
    }
    
    func fetchUserConnections(userID: String, completion: @escaping (Int, Int, Error?) -> Void) {
        db.collection("userConnections")
            .whereField("userID", isEqualTo: userID)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(0, 0, error)
                    return
                }
                let data = querySnapshot?.documents.first?.data() ?? [:]
                let followers = data["followers"] as? [String] ?? []
                let following = data["following"] as? [String] ?? []
                completion(followers.count, following.count, nil)
            }
    }
}

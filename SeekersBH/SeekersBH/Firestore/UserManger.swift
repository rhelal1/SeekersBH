//
//  UserManger.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//

import Foundation

import FirebaseFirestore

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

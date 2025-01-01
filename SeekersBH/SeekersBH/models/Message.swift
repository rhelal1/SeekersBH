//
//  Message.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//

import Foundation
import FirebaseFirestore

public struct Message: Codable {
    var senderId: String
    var message: String
    var timestamp: Timestamp
    
    // Computed property to easily convert timestamp to a readable Date
    var date: Date {
        return timestamp.dateValue()
    }
}

//
//  ChatManager.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//

import Foundation
import FirebaseFirestore

class ChatManager {
    
    private var db = Firestore.firestore()
    private var chatId: String
    
    // Initialize with two user IDs, automatically sorting and generating or retrieving the chatId
    init(userId1: String, userId2: String, completion: ((String) -> Void)? = nil) {
        // Sort the user IDs to ensure consistent chatId
        let sortedUserIds = [userId1, userId2].sorted()
        self.chatId = ChatManager.generateChatId(userId1: sortedUserIds[0], userId2: sortedUserIds[1])
        
        // Check if a chat already exists between the two users
        getChatId(forUserId: sortedUserIds[0], userId2: sortedUserIds[1]) { existingChatId in
            if let existingChatId = existingChatId {
                // If the chat exists, use the existing chatId
                self.chatId = existingChatId
                completion?(self.chatId) // Call completion if provided
            } else {
                // If no chat exists, create a new chat
                self.createNewChat(forUserId: sortedUserIds[0], userId2: sortedUserIds[1]) { newChatId in
                    self.chatId = newChatId
                    completion?(self.chatId) // Call completion if provided
                }
            }
        }
    }
    
    // Generate a unique chatId based on the two sorted user IDs
    static func generateChatId(userId1: String, userId2: String) -> String {
        return "\(userId1)_\(userId2)"  // Combine the sorted user IDs to form a unique chat ID
    }
    
    // Check if a chat already exists between the two users
    private func getChatId(forUserId userId1: String, userId2: String, completion: @escaping (String?) -> Void) {
        let chatRef = db.collection("chats").document(self.chatId)
        
        chatRef.getDocument { document, error in
            if let document = document, document.exists {
                // Chat exists, return the chatId
                completion(self.chatId)
            } else {
                // Chat doesn't exist, return nil
                completion(nil)
            }
        }
    }
    
    // Create a new chat between two users
    private func createNewChat(forUserId userId1: String, userId2: String, completion: @escaping (String) -> Void) {
        let chatRef = db.collection("chats").document(self.chatId)
        
        let chatData: [String: Any] = [
            "users": [userId1, userId2],
            "createdAt": Timestamp()  // You can add more fields as needed
        ]
        
        // Set the data for the chat document
        chatRef.setData(chatData) { error in
            if let error = error {
                print("Error creating chat: \(error.localizedDescription)")
                return
            }
            
            print("Chat created successfully!")
            completion(self.chatId)
        }
    }
    
    // Listen for new messages in the chat in real-time
    func listenForMessages(completion: @escaping ([Message]) -> Void) {
        let messagesRef = db.collection("chats").document(self.chatId).collection("messages")
        
        // Order by timestamp to display messages in the correct order
        messagesRef.order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    print("Error listening for messages: \(error?.localizedDescription ?? "")")
                    return
                }
                
                var messages = [Message]()
                
                // Parse messages
                for document in snapshot.documents {
                    do {
                        let message = try document.data(as: Message.self)
                        messages.append(message)
                    } catch {
                        print("Error decoding message: \(error.localizedDescription)")
                    }
                }
                
                // Return the messages through the completion handler
                completion(messages)
            }
    }
    
    // Send a text message to the chat
    func sendMessage(senderId: String, messageText: String, completion: ((Bool) -> Void)? = nil) {
        let messagesRef = db.collection("chats").document(self.chatId).collection("messages")
        
        let newMessage: [String: Any] = [
            "senderId": senderId,
            "message": messageText,
            "timestamp": Timestamp()  // Only the timestamp, sender, and message
        ]
        
        // Add the new message to Firestore
        messagesRef.addDocument(data: newMessage) { error in
            if let error = error {
                print("Error sending message: \(error.localizedDescription)")
                completion?(false)
            } else {
                print("Message sent successfully!")
                completion?(true)
            }
        }
    }
    
    // Get all messages from the first to the last (oldest to newest)
    func getAllMessages(completion: @escaping ([Message]) -> Void) {
        let messagesRef = db.collection("chats").document(self.chatId).collection("messages")
        
        // Order by timestamp in ascending order (oldest first)
        messagesRef.order(by: "timestamp", descending: false) // Set descending to false for oldest first
            .getDocuments { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    print("Error fetching messages: \(error?.localizedDescription ?? "")")
                    completion([]) // Return an empty array in case of error
                    return
                }
                
                var messages = [Message]()
                
                // Parse all messages from Firestore documents
                for document in snapshot.documents {
                    do {
                        let message = try document.data(as: Message.self)
                        messages.append(message)
                    } catch {
                        print("Error decoding message: \(error.localizedDescription)")
                    }
                }
                
                // Return the messages through the completion handler
                completion(messages)
            }
    }
    
}

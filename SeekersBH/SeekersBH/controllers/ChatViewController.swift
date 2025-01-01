//
//  ChatViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//

import UIKit
import FirebaseCore

class ChatViewController: UIViewController {
    public var receiverId: String?
    private var recevier: User?
    private var chatManager: ChatManager?
    private var messages: [Message] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var navItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "messageCell")
        tableView.allowsSelection = false
        
        prepareForUser(with: receiverId ?? "--")
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func prepareForUser(with id: String) {
        sendButton.isEnabled = false
        UserManger.shared.fetchAllUsers() { users in
            let receiver = users.first { $0.id == id }
            
            if receiver == nil {
                let alert = UIAlertController(title: "User not found", message: "The user you are looking for could not be found.", preferredStyle: .alert)
                
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                alert.addAction(dismissAction)
                
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let receiver = receiver else {
                return
            }
            
            self.recevier = receiver
            self.chatManager = ChatManager(userId1: AccessManager.userID!, userId2: self.receiverId!) {_ in
                self.chatReady()
            }
            //to do
            self.navItem.title = receiver.userName
        }
    }
    
    private func chatReady() {
        // Fetch all previous messages and listen for new ones
        chatManager?.getAllMessages { messages in
            self.messages = messages
            self.tableView.reloadData()  // Reload the table view with previous messages
        }
        
        // Listen for new messages in real-time
        chatManager?.listenForMessages { newMessages in
            self.messages = newMessages
            self.tableView.reloadData()  // Reload table view to show new messages
            self.scrollToBottom()  // Scroll to the latest message
        }
        
        sendButton.isEnabled = true
    }
    
    private func scrollToBottom() {
        guard !messages.isEmpty else { return }
        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        
        chatManager?.sendMessage(senderId: AccessManager.userID!, messageText: text) { success in
            if success {
                self.messageTextField.text = ""  // Clear the text field
            } else {
                // Handle failure in sending message
                print("Failed to send message.")
            }
        }
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        // Clear any previous subviews added to the cell's content view
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Get the message
        let message = messages[indexPath.row]
        
        // Create the bubble view
        let bubbleView = UIView()
        bubbleView.backgroundColor = message.senderId == AccessManager.userID ? UIColor.systemGreen : UIColor.systemBlue
        bubbleView.layer.masksToBounds = true
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(bubbleView)
        
        // Create the message label
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0  // Allow multi-line text
        messageLabel.text = message.message
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textColor = .white
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(messageLabel)
        
        // Constraints for the bubble view
        let maxWidth = tableView.frame.width * 0.75  // Set a max width for the bubble
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth),
            bubbleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),  // Minimum height
        ])
        
        // Adjust the leading/trailing constraints for the bubble view
        if message.senderId == AccessManager.userID {
            bubbleView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16).isActive = true
            bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: cell.contentView.leadingAnchor, constant: 16).isActive = true
        } else {
            bubbleView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16).isActive = true
            bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: cell.contentView.trailingAnchor, constant: -16).isActive = true
        }
        
        // Constraints for the message label (inside the bubble view)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),    // Padding
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8), // Padding
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12), // Padding
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12) // Padding
        ])
        
        // Adjust the corner radius for the bubble view after layout updates
        bubbleView.layoutIfNeeded()
        bubbleView.layer.cornerRadius = (bubbleView.frame.height / 2) - 5
        
        return cell
    }
    
    
}

//
//  ProfileViewController.swift
//  SeekersBH
//
//  Created by Natheer on 28/12/2024.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tappedChatButton(_ sender: Any) {
        // get the user id of the chat to be opened
        
        let chatVC = UIStoryboard(name: "chat", bundle: nil).instantiateInitialViewController() as! ChatViewController
        
        /// uncomment to present as a full screen
//        chatVC.modalPresentationStyle = .fullScreen
        
//        chatVC.receiverId = "PUT THE ID OF THE CHAT TO OPEN AND UNCOMMENT"
        
        present(chatVC, animated: true)
        
    }
}

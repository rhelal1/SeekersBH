//
//  ProfileViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 28/12/2024.
//

import UIKit


//public var openedUserID = ""


class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    
    var userID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserProfile()
    }

    //fetch email - username
    func fetchUserProfile() {
        UserManger.shared.fetchUserInfo(userID: userID) { [weak self] data, error in
               guard let self = self, let data = data, error == nil else { return }
               DispatchQueue.main.async {
                   self.emailLabel.text = data["email"] as? String ?? ""
                   self.usernameLabel.text = data["username"] as? String ?? ""
               }
           }

           // Fetch connections
        UserManger.shared.fetchUserConnections(userID: userID) { [weak self] followers, following, error in
               guard let self = self, error == nil else { return }
               DispatchQueue.main.async {
                   self.followersLabel.text = "Followers: \(followers)"
                   self.followingLabel.text = "Following: \(following)"
               }
           }
       }
    
    
    
    
    
    @IBAction func tappedChatButton(_ sender: Any) {
        let chatVC = UIStoryboard(name: "chat", bundle: nil).instantiateInitialViewController() as! ChatViewController
        
        chatVC.modalPresentationStyle = .fullScreen
        
        chatVC.receiverId = userID
        
        present(chatVC, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfileDetails" {
            let destinationVC = segue.destination as! ProfileTableViewTableViewController
            destinationVC.userID = self.userID 
        }
    }

   }


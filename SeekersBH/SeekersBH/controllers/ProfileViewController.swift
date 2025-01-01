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
    
    @IBOutlet weak var follow: UIButton!
    
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
                self.followersLabel.text = "\(followers.count) Followers"
                self.followingLabel.text = "\(following.count) Following"
            }
            
            if let currentUserID = AccessManager.userID {
                let isFollowing = followers.contains(currentUserID)
                if isFollowing {
                    self.updateFollowButton(title: "Unfollow", colorHex: "#7C7C7C")
                } else {
                    self.updateFollowButton(title: "Follow", colorHex: "#0D1852")
                }
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
    
    @IBAction func clickFollow(_ sender: Any) {
        guard let currentUserID = AccessManager.userID else { return }
        
        UserManger.shared.toggleFollowStatus(userID: userID, followerID: currentUserID) { [weak self] success, isFollowing, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success {
                    if isFollowing {
                        self.updateFollowButton(title: "Unfollow", colorHex: "#7C7C7C")
                    } else {
                        self.updateFollowButton(title: "Follow", colorHex: "#0D1852")
                    }
                    
                    // Refresh the followers and following counts
                    self.fetchUserProfile()
                } else {
                    print("Error toggling follow status: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
            
        }
    }
    
    private func updateFollowButton(title: String, colorHex: String) {
        var config = follow.configuration ?? UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(hex: colorHex)
        follow.configuration = config
        follow.setTitle(title, for: .normal)

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Helvetica-Bold", size: 26.0) ?? UIFont.systemFont(ofSize: 26.0),
            .foregroundColor: UIColor.white
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        follow.setAttributedTitle(attributedTitle, for: .normal)

//        follow.backgroundColor = UIColor(hex: colorHex)

        follow.layer.cornerRadius = 5
        follow.layer.masksToBounds = true
        follow.setNeedsDisplay() // Force redraw
        follow.layoutIfNeeded()
    }

}

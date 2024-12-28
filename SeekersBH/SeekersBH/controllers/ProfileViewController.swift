//
//  ProfileViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 28/12/2024.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    
    var userID = ""
//       var skills: [String] = []
//       var interests: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

               fetchUserProfile()
    }

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

           // Fetch skills
//        UserManger.shared.fetchUserSkills(userID: userID) { [weak self] skills, error in
//               guard let self = self, error == nil else { return }
//               self.skills = skills
//               DispatchQueue.main.async {
//                   self.tableView.reloadData()
//               }
//           }

           // Fetch interests
//        UserManger.shared.fetchUserInterests(userID: userID) { [weak self] interests, error in
//               guard let self = self, error == nil else { return }
//               self.interests = interests
//               DispatchQueue.main.async {
//                   self.tableView.reloadData()
//               }
//           }
       }
    
    
    
    
    
    @IBAction func tappedChatButton(_ sender: Any) {
        // get the user id of the chat to be opened
        
        let chatVC = UIStoryboard(name: "chat", bundle: nil).instantiateInitialViewController() as! ChatViewController
        
        /// uncomment to present as a full screen
        chatVC.modalPresentationStyle = .fullScreen
        
        chatVC.receiverId = userID
        
        present(chatVC, animated: true)
        
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//           return 2 // One for interests, one for skills
//       }

//       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           if section == 0 {
//               return interests.count
//           } else {
//               return skills.count
//           }
//       }

//       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           if indexPath.section == 0 {
//               let cell = tableView.dequeueReusableCell(withIdentifier: "InterestCell", for: indexPath)
//               cell.textLabel?.text = interests[indexPath.row]
//               return cell
//           } else {
//               let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath)
//               cell.textLabel?.text = skills[indexPath.row]
//               return cell
//           }
//       }

//       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//           return section == 0 ? "Interests" : "Skills"
//       }
   }


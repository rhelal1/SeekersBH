//
//  UserMangeViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//

import UIKit

class UserMangeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var toggleUsersButton: UIButton!
    var users: [User] = []
    var allUsers: [User] = []
    var isShowingHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        UserManger.shared.fetchAllUsers { [weak self] fetchedUsers in
            self?.allUsers = fetchedUsers
            DispatchQueue.main.async {
                self?.updateVisibleUsers()
            }
        }
        
    }
    @IBAction func didTapToggleUsers(_ sender: Any) {
        isShowingHidden.toggle()
        toggleUsersButton.setTitle(isShowingHidden ? "Hide disabled user" : "Show disabled user", for: .normal)
        updateVisibleUsers()
    }
    func updateVisibleUsers() {
        users = isShowingHidden ? allUsers.filter { $0.isHidden } : allUsers.filter { !$0.isHidden }
        tableView.reloadData()
    }
    
    func updateUserVisibility(userID: String, isHidden: Bool) {
        if let index = allUsers.firstIndex(where: { $0.id == userID }) {
            allUsers[index].isHidden = isHidden
        }
        
        updateVisibleUsers()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserMangeCell", for: indexPath) as! UserMangeCell
        
        cell.update(with: users[indexPath.row])
        cell.parentVC = self
        
        return cell
    }
    
    @IBAction func clickViewProfile(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? UserMangeCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        
        let selectedUser = users[indexPath.row]
        
        let storyboard = UIStoryboard(name: "zainab", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
            profileVC.userID = selectedUser.id
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}

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

        fetchAllUsers { [weak self] fetchedUsers in
            self?.allUsers = fetchedUsers
            DispatchQueue.main.async {
                self?.updateVisibleUsers()
            }
        }
    
    }
    @IBAction func didTapToggleUsers(_ sender: Any) {
        isShowingHidden.toggle()
                toggleUsersButton.setTitle(isShowingHidden ? "Hide Hidden" : "Show Hidden", for: .normal)
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
}

//
//  UserMangeViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//

import UIKit

class UserMangeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
              tableView.dataSource = self
              
              fetchAllUsers { [weak self] fetchedUsers in
                  self?.users = fetchedUsers
                  DispatchQueue.main.async {
                      self?.tableView.reloadData()
                  }
              }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserMangeCell", for: indexPath) as! UserMangeCell
            
            let user = users[indexPath.row]
            cell.update(with: user)
            
            return cell
        }

}

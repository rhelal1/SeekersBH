//
//  UserMangeCell.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//

import UIKit

class UserMangeCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    func update(with user: User) {
        username.text = user.userName
        email.text = user.email
        }
}

//
//  UserMangeCell.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//

import UIKit


class UserMangeCell: UITableViewCell {
    
    var user: User?
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var email: UILabel!
    weak var parentVC: UserMangeViewController?
    
    func update(with user: User) {
        self.user = user
        username.text = user.userName
        email.text = user.email
        actionButton.setTitle(user.isHidden ? "Unhide" : "Hide", for: .normal)
        }
    @IBAction func didTapActionButton(_ sender: Any) {
        guard let parentVC = parentVC, let userID = user?.id else { return }

          let newHiddenState = !(user?.isHidden ?? false)

          self.user?.isHidden = newHiddenState
          self.actionButton.setTitle(newHiddenState ? "Unhide" : "Hide", for: .normal)

          FirebaseManager.shared.updateDocument(
              collectionName: "User",
              documentId: userID,
              data: ["isHidden": newHiddenState]
          ) { error in
              if let error = error {
                  print("Failed to update visibility: \(error.localizedDescription)")
                  self.user?.isHidden.toggle()
                  self.actionButton.setTitle(self.user!.isHidden ? "Unhide" : "Hide", for: .normal)
              } else {
                  parentVC.updateUserVisibility(userID: userID, isHidden: newHiddenState)
              }
          }
    }
}


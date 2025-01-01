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
        actionButton.setTitle(user.isHidden ? "Enable" : "Disable", for: .normal)

        }
    @IBAction func didTapActionButton(_ sender: Any) {
            guard let parentVC = parentVC, let userID = user?.id else { return }
            
            let newHiddenState = !(user?.isHidden ?? false)
            let confirmationMessage = newHiddenState
                ? "Are you sure you want to disable this user?"
                : "Are you sure you want to enable this user?"
            
            let alert = UIAlertController(
                title: "Confirmation",
                message: confirmationMessage,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
                self.toggleUserVisibility(userID: userID, newHiddenState: newHiddenState, parentVC: parentVC)
            })
            
            parentVC.present(alert, animated: true, completion: nil)
        }
        
        private func toggleUserVisibility(userID: String, newHiddenState: Bool, parentVC: UserMangeViewController) {
            self.user?.isHidden = newHiddenState
            self.actionButton.setTitle(newHiddenState ? "Enable" : "Disable", for: .normal)
            
            FirebaseManager.shared.updateDocument(
                collectionName: "User",
                documentId: userID,
                data: ["isHidden": newHiddenState]
            ) { error in
                if let error = error {
                    print("Failed to update visibility: \(error.localizedDescription)")
                    self.user?.isHidden.toggle()
                    self.actionButton.setTitle(self.user!.isHidden ? "Enable" : "Disable", for: .normal)
                } else {
                    parentVC.updateUserVisibility(userID: userID, isHidden: newHiddenState)
                }
            }
        }
    }

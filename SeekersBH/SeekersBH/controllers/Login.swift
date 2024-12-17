//
//  Login.swift
//  SeekersBH
//
//  Created by Reem work on 13/12/2024.
//

import UIKit

class Login: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var passwordTxtBx: UITextField!
    @IBOutlet weak var usernameTxtBx: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!

    @IBAction func LoginMessage(_ sender: Any) {
        // Validate username and password fields
        guard let username = usernameTxtBx.text, !username.isEmpty else {
            showAlert(title: "Error", message: "Username cannot be empty.")
            return
        }
        
        guard let password = passwordTxtBx.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Password cannot be empty.")
            return
        }
        
        // Show a success message if validation passes
        showAlert(title: "Success", message: "You logged in successfully!")
    }
    
    // Helper function to show alerts
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  RegisterViewController.swift
//  SeekersBH
//
//  Created by Natheer work on 12/12/2024.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var confirmPasswordtxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    @IBOutlet weak var MostRecentCompanytxt: UITextField!
    @IBOutlet weak var mostRecentJobTitle: UITextField!
    @IBOutlet weak var locationtxt: UITextField!
    @IBOutlet weak var datetxt: UIDatePicker!
    @IBOutlet weak var usernametxt: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var donebtn: UIButton!
    @IBOutlet weak var emailtxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func donebtn(_ sender: Any) {
        // Check if all text fields are filled
            guard let firstName = fName.text, !firstName.isEmpty,
                  let lastName = lName.text, !lastName.isEmpty,
                  let email = emailtxt.text, !email.isEmpty,
                  let username = usernametxt.text, !username.isEmpty,
                  let location = locationtxt.text, !location.isEmpty,
                  let mostRecentCompany = MostRecentCompanytxt.text, !mostRecentCompany.isEmpty,
                  let mostRecentJobTitle = mostRecentJobTitle.text, !mostRecentJobTitle.isEmpty else {
                showAlert(message: "Please fill in all fields.")
                return
            }
            
            // Check if passwords match
            guard let password = passwordtxt.text, !password.isEmpty,
                  let confirmPassword = confirmPasswordtxt.text, !confirmPassword.isEmpty else {
                showAlert(message: "Please enter both password fields.")
                return
            }
            
            if password != confirmPassword {
                showAlert(message: "Passwords do not match.")
                return
            }
            
            // Continue with registration or any other process
            // Example: Save the data or proceed to the next screen
            print("All fields are valid. Proceed with registration.")
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

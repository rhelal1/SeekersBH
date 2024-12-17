//
//  CreateCVView.swift
//  SeekersBH
//
//  Created by marwa on 12/12/2024.
//

import UIKit

class CreateCVView: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var linkedInField: UITextField!
    @IBOutlet weak var portfolioField: UITextField!
    
    // variables to Store Input
    var fullName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var linkedIn: String = ""
    var portfolio: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    // IBActions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // retrieve inputs and store them in variables
        fullName = fullNameField.text ?? ""
        email = emailField.text ?? ""
        phoneNumber = phoneNumberField.text ?? ""
        linkedIn = linkedInField.text ?? ""
        portfolio = portfolioField.text ?? ""

        // debug: Print the inputs to console
        print("Full Name: \(fullName)")
        print("Email: \(email)")
        print("Phone Number: \(phoneNumber)")
        print("LinkedIn: \(linkedIn)")
        print("Portfolio: \(portfolio)")

        // validations or passing data to another screen later
        showAlertWithMessage("CV Data Saved Successfully!")
    }
    
    // helper
    func showAlertWithMessage(_ message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  CreateCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 18/12/2024.
//

import UIKit

class CreateCVViewController: UIViewController {
    
    
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var linkedInField: UITextField!
    @IBOutlet weak var portfolioField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if fullNameField.text?.isEmpty ?? true {
            showAlert(message: "Full Name cannot be empty.")
            return
        }
        
        CVManager.shared.cv.fullName = fullNameField.text ?? ""
        
        if emailField.text?.isEmpty ?? true {
            showAlert(message: "Email cannot be empty.")
            return
        } else if let email = emailField.text, !isValidEmail(email) {
            showAlert(message: "Invalid email format.")
            return
        }
        
        CVManager.shared.cv.email = emailField.text ?? ""
        
        if let phoneNumber = phoneNumberField.text, phoneNumber.isEmpty {
            showAlert(message: "Phone Number cannot be empty.")
            return
        } else if let phoneNumber = phoneNumberField.text, !isValidPhoneNumber(phoneNumber) {
            showAlert(message: "Please enter a valid Phone Number.")
            return
        }
        
        CVManager.shared.cv.phoneNumber = phoneNumberField.text ?? ""
        
        if let linkedIn = linkedInField.text, linkedIn.isEmpty {
            showAlert(message: "LinkedIn URL cannot be empty.")
            return
        } else if let linkedIn = linkedInField.text, !isValidURL(linkedIn) {
            showAlert(message: "Please enter a valid LinkedIn URL.")
            return
        }
        
        CVManager.shared.cv.likedInURL = linkedInField.text ?? ""
        
        if let portfolio = portfolioField.text, portfolio.isEmpty {
            showAlert(message: "Portfolio URL cannot be empty.")
            return
        } else if let portfolio = portfolioField.text, !isValidURL(portfolio) {
            showAlert(message: "Please enter a valid Portfolio URL.")
            return
        }
        
        CVManager.shared.cv.protofolioURL = portfolioField.text ?? ""
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^[0-9]{8,15}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    func isValidURL(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            return false
        }
        return true
    }
}

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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if fullNameField.text?.isEmpty ?? true {
            showAlert(message: "Full Name cannot be empty.")
            return
        }
        
        CVManager.shared.cv.fullName = fullNameField.text ?? ""
        // printing just to make sure it is saved
        print("Saved Full Name: \(CVManager.shared.cv.fullName)")
        
        if emailField.text?.isEmpty ?? true {
            showAlert(message: "Email cannot be empty.")
            return
        } else if let email = emailField.text, !isValidEmail(email) {
            showAlert(message: "Invalid email format.")
            return
        }
        
        CVManager.shared.cv.email = emailField.text ?? ""
        // printing just to make sure it is saved
        print("Saved Email: \(CVManager.shared.cv.email)")
        
        if let phoneNumber = phoneNumberField.text, phoneNumber.isEmpty {
            showAlert(message: "Phone Number cannot be empty.")
            return
        } else if let phoneNumber = phoneNumberField.text, !isValidPhoneNumber(phoneNumber) {
            showAlert(message: "Please enter a valid Phone Number.")
            return
        }
        
        CVManager.shared.cv.phoneNumber = phoneNumberField.text ?? ""
        // printing just to make sure it is saved
        print("Saved Phone Number: \(CVManager.shared.cv.phoneNumber)")
        
        if let linkedIn = linkedInField.text, linkedIn.isEmpty {
            showAlert(message: "LinkedIn URL cannot be empty.")
            return
        } else if let linkedIn = linkedInField.text, !isValidURL(linkedIn) {
            showAlert(message: "Please enter a valid LinkedIn URL.")
            return
        }
        
        CVManager.shared.cv.likedInURL = linkedInField.text ?? ""
        // printing just to make sure it is saved
        print("Saved LinkedIn URL: \(CVManager.shared.cv.likedInURL)")
        
        if let portfolio = portfolioField.text, portfolio.isEmpty {
            showAlert(message: "Portfolio URL cannot be empty.")
            return
        } else if let portfolio = portfolioField.text, !isValidURL(portfolio) {
            showAlert(message: "Please enter a valid Portfolio URL.")
            return
        }
        
        CVManager.shared.cv.protofolioURL = portfolioField.text ?? ""
        // printing just to make sure it is saved
        print("Saved Portfolio URL: \(CVManager.shared.cv.protofolioURL)")
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
        let phoneRegex = "^[0-9]{8,15}$" // Allows numbers with 8 to 15 digits
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    func isValidURL(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            return false
        }
        return true
    }
    
    
    //    func configureCreateCVController(navigationController: UINavigationController?, fullName: String, aboutMe: String? = nil) {
    //
    //        guard let createCVController = navigationController as? CreateCVNavigationController else {
    //            print("Error: Navigation controller is not of type CreateCVNavigationController.")
    //            return
    //        }
    //
    //        // Assign the properties
    //        createCVController.fullName = fullName
    //
    //        }
    //
}

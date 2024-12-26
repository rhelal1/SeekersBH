//
//  AddEmployerViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 19/12/2024.
//

import UIKit

class AddEmployerViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var DOB: UITextField!
    
    @IBOutlet weak var JobTitle: UITextField!
    
    @IBOutlet weak var company: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func saveEmployerData(_ sender: UIButton) {
        guard let username = username.text, !username.isEmpty,
              let firstName = firstname.text, !firstName.isEmpty,
              let lastName = lastname.text, !lastName.isEmpty,
              let city = city.text, !city.isEmpty,
              let dob = DOB.text, !dob.isEmpty,
              let jobTitle = JobTitle.text, !jobTitle.isEmpty,
              let company = company.text, !company.isEmpty,
              let password = password.text, !password.isEmpty,
              let email = email.text, !email.isEmpty else {
            print("Please fill out all fields.")
            return
        }
        
        let documentReference = FirebaseManager.shared.db.collection("Employer").document()
           let documentID = documentReference.documentID
        
        let employerData: [String: String] = [
            "id":documentID,
            "username": username,
            "firstName": firstName,
            "lastName": lastName,
            "city": city,
            "dateofbirth": dob,
            "jobtitle": jobTitle,
            "company": company,
            "password": password,
            "email": email
        ]
        
        FirebaseManager.shared.addDocumentToCollection(collectionName: "Employer", data: employerData)
        
    }
}

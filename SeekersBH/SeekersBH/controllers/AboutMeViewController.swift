//
//  AboutMeViewController.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import UIKit

class AboutMeViewController: UIViewController {
    
    @IBOutlet weak var aboutMeField: UITextField!
    @IBOutlet weak var cvName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if cvName.text?.isEmpty ?? true {
            showAlert(message: "CV Name cannot be empty.")
            return
        }
        CVManager.shared.cv.cvName = cvName.text ?? ""
        
        if aboutMeField.text?.isEmpty ?? true {
            showAlert(message: "About Me field cannot be empty.")
            return
        }
        CVManager.shared.cv.aboutMe = aboutMeField.text ?? ""
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

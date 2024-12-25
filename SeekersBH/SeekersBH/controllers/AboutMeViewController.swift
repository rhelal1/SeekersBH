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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if cvName.text?.isEmpty ?? true {
            showAlert(message: "CV Name cannot be empty.")
            return
        }
        CVManager.shared.cv.cvName = cvName.text ?? ""
        // printing just to make sure it is saved
        print("Saved CV Name: \(CVManager.shared.cv.cvName)")
        
        if aboutMeField.text?.isEmpty ?? true {
            showAlert(message: "About Me field cannot be empty.")
            return
        }
        CVManager.shared.cv.aboutMe = aboutMeField.text ?? ""
        // printing just to make sure it is saved
        print("Saved About Me: \(CVManager.shared.cv.aboutMe)")
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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

//
//  EducationCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import UIKit

class EducationCVViewController: UIViewController {
    
    @IBOutlet weak var highestDegreeField: UITextField!
    @IBOutlet weak var universityField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTabbed(_ sender: UIButton) {
        if highestDegreeField.text?.isEmpty ?? true {
            showAlert(message: "Highest degree field cannot be empty.")
            return
        }
        CVManager.shared.cv.highestDegree = highestDegreeField.text ?? ""
        // printing just to make sure it is saved
        print("Saved Highest Degree: \(CVManager.shared.cv.highestDegree)")
        if universityField.text?.isEmpty ?? true {
            showAlert(message: "University field cannot be empty.")
            return
        }
        CVManager.shared.cv.university = universityField.text ?? ""
        // printing just to make sure it is saved
        print("Saved University: \(CVManager.shared.cv.university)")
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

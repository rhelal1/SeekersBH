//
//  SkillCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import UIKit

class SkillCVViewController: UIViewController {
    
    @IBOutlet weak var skillName: UITextField!
    @IBOutlet weak var otherSkills: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if skillName.text?.isEmpty ?? true {
            showAlert(message: "skills cannot be empty.")
            return
        }
        CVManager.shared.cv.skills = skillName.text ?? ""
        // printing just to make sure it is saved
        print("Saved skill: \(CVManager.shared.cv.skills)")
        CVManager.shared.cv.otherSkills = otherSkills.text ?? ""
        // printing just to make sure it is saved
        print("Saved other skill: \(CVManager.shared.cv.otherSkills)")
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

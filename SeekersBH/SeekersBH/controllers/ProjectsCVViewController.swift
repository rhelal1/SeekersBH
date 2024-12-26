//
//  ProjectsCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import UIKit

class ProjectsCVViewController: UIViewController {
    
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectOverview: UITextField!
    @IBOutlet weak var projectURL: UITextField!
    @IBOutlet weak var otherProjects: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if projectName.text?.isEmpty ?? true {
            showAlert(message: "Project Name cannot be empty.")
            return
        }
        
        if projectOverview.text?.isEmpty ?? true {
            showAlert(message: "Project Overview cannot be empty.")
            return
        }
        
        if projectURL.text?.isEmpty ?? true {
            showAlert(message: "Project URL cannot be empty.")
            return
        }
        
        if !isValidURL(projectURL.text) {
            showAlert(message: "Please enter a valid URL.")
            return
        }
        
        
        let newProject = Project(
            name: projectName.text ?? "",
            overview: projectOverview.text ?? "",
            resource: projectURL.text ?? ""
        )
        
        CVManager.shared.cv.projectSecions.append(newProject)
        
        // printing just to make sure it is saved
        print("Saved Project: \(newProject.name), Overview: \(newProject.overview), URL: \(newProject.resource)")
        
        CVManager.shared.cv.otherProjects = otherProjects.text ?? ""
        // printing just to make sure it is saved
        print("Saved other projects: \(CVManager.shared.cv.otherProjects)")
        
        CVManager.shared.saveCVToFirebase()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func isValidURL(_ urlString: String?) -> Bool {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
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

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
        
        CVManager.shared.cv.otherProjects = otherProjects.text ?? ""
        
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
}

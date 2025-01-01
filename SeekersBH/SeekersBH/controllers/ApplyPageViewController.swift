//
//  ApplyPageViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 16/12/2024.
//

import UIKit

class ApplyPageViewController: UIViewController {

    @IBOutlet weak var Contiuebtn: UIButton!
    
    // Temporarily store data
        var tempJobApplication: JobApplication?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func continuebtn(_ sender: Any) {
        
       
        // Collect data from the NewApplyPageFormTableViewController
            if let jobApplication = collectFormData() {
                // Temporarily store the job application data
                tempJobApplication = jobApplication
                
                // Segue is triggered automatically by the storyboard; no need to call performSegue
            } else {
                // Show alert if form data is invalid
                showAlert(message: "Please fill out all required fields.")
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCVViewController", let nextVC = segue.destination as? CVSelectionJobApplicationViewController {
            nextVC.tempJobApplication = tempJobApplication
        }
    }

    
    // Method to collect form data from NewApplyPageFormTableViewController
        func collectFormData() -> JobApplication? {
            // Initialize the NewApplyPageFormTableViewController
            if let formVC = self.children.first(where: { $0 is NewApplyPageFormTableViewController }) as? NewApplyPageFormTableViewController {
                return formVC.collectFormData()
            }
            return nil
        }
    

    // Show an alert if required fields are missing
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

}


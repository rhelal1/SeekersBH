//
//  testViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class TestViewController: UIViewController {
    

    @IBAction func nextbtn(_ sender: UIButton) {
                if validateInput() {
                  performSegue(withIdentifier: "toAddJobView2", sender: self) // Proceed if validation passes
              }
    }
    @IBOutlet weak var JobTypeTxtField: UITextField!
    @IBOutlet weak var JobLocationTxtField: UITextField!
    @IBOutlet weak var jobNameTxtField: UITextField!
    @IBOutlet weak var viewTest: UIView!
    
    var job: JobAd? // Receive JobAd object
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTest.layer.cornerRadius = 15
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddJobView2", // Match  the storyboard segue identifier
           let destination = segue.destination as? AddJobView2ViewController {
            let job = JobAd(
                jobName: jobNameTxtField.text ?? "",
                jobLocation: JobLocationTxtField.text ?? "",
                jobType: .fullTime // Map JobType if necessary
            )
            destination.job = job
        }
    }
    private func validateInput() -> Bool {
            // Check if job name is empty
            if jobNameTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                showAlert(message: "Please enter the job name.")
                return false
            }
            
            // Check if job location is empty
            if JobLocationTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                showAlert(message: "Please enter the job location.")
                return false
            }
            
        // Check if job type is valid
                let validJobTypes = ["full-time", "part-time", "contract", "temporary"]
                let jobType = JobTypeTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
                if !validJobTypes.contains(jobType) {
                    showAlert(message: "Please enter a valid job type: full-time, part-time, contract, or temporary.")
                    return false
                }
            
            return true // Validation passed
        }
    private func showAlert(message: String) {
            let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }


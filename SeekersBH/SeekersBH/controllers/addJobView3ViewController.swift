//
//  addJobView3ViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class addJobView3ViewController: UIViewController {
    
    @IBOutlet weak var applicationdeadline: UIDatePicker!
    @IBOutlet weak var AdditionalPerksTxtView: UITextView!
    @IBOutlet weak var salaryRangetxtField: UITextField!
    var job: JobAd? // Receive JobAd object
    @IBAction func finishbtn(_ sender: UIButton) {
        showAlert()
        saveJob()
        JobManager.shared.printSavedJobs()
    }
    @IBOutlet weak var vieww: UIView!
    @IBOutlet weak var textview1: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        vieww.layer.cornerRadius = 10
        textview1.layer.cornerRadius = 10
    }
    
    func saveJob() {
            if var job = job {
                // Update job properties with the current input
                job.jobSalary = salaryRangetxtField.text ?? ""
                job.jobApplicationDeadline = applicationdeadline.date
                
                let additionalPerksText = AdditionalPerksTxtView.text.trimmingCharacters(in: .whitespacesAndNewlines)
                job.additionalPerks = additionalPerksText.isEmpty ? [] : additionalPerksText.components(separatedBy: ",")
                
                // Append the updated job object to the shared job array
                JobManager.shared.jobs.append(job)
            }
        }
    
    func showAlert() {
        // Create the alert controller
        let alert = UIAlertController(title: "", message: "Job Application added Successfully", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Done", style: .default) { _ in
                // Ensure you’re only performing the segue once
                if !self.isSegueAlreadyPerformed {
                    self.isSegueAlreadyPerformed = true
                    self.performSegue(withIdentifier: "goToNextPage", sender: self)
                }
               
            }
        
        
        // Add the action to the alert
        alert.addAction(okAction)
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    // Validation function
        private func validateInput() -> Bool {
            // Validate salary range
            guard let salaryRange = salaryRangetxtField.text,
                  !salaryRange.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                showAlert(message: "Salary range cannot be empty.")
                return false
            }
            
            // Check if the salary range is numeric or matches a range format
            let salaryRangePattern = #"^\d{1,6}-\d{1,6}$|^\d{1,6}$"#
            if !NSPredicate(format: "SELF MATCHES %@", salaryRangePattern).evaluate(with: salaryRange) {
                showAlert(message: "Salary range must be a number or in the format 'min-max' (e.g., 3000-5000).")
                return false
            }
            
            // Validate additional perks
            let additionalPerksText = AdditionalPerksTxtView.text.trimmingCharacters(in: .whitespacesAndNewlines)
            if additionalPerksText.isEmpty {
                showAlert(message: "Please enter at least one additional perk.")
                return false
            }
            
            // Validate application deadline
            let today = Date()
            if applicationdeadline.date < today {
                showAlert(message: "The application deadline must be a future date.")
                return false
            }
            
            return true
        }
    
    // Alert function for validation errors
        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        var isSegueAlreadyPerformed = false
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



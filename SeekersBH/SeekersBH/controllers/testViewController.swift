//
//  testViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class TestViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func nextbtn(_ sender: UIButton) {
        if validateInput() {
            // Segue will be handled by the storyboard
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
        
        // Set delegate for text fields
        jobNameTxtField.delegate = self
        JobLocationTxtField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddJobView2", // Match the storyboard segue identifier
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
            showAlert(message: "Job name cannot be empty. Please enter a valid job name.")
            return false
        }
        
        // Check if job name contains numeric values
        if containsNumbers(jobNameTxtField.text ?? "") {
            showAlert(message: "Job name cannot contain numbers. Please enter a valid name.")
            return false
        }
        
        // Check if job location is empty
        if JobLocationTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            showAlert(message: "Job location cannot be empty. Please enter a valid location.")
            return false
        }
        
        // Check if job location contains numeric values
        if containsNumbers(JobLocationTxtField.text ?? "") {
            showAlert(message: "Job location cannot contain numbers. Please enter a valid location.")
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
    
    private func containsNumbers(_ text: String) -> Bool {
        let numberRange = text.rangeOfCharacter(from: .decimalDigits)
        return numberRange != nil
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // UITextFieldDelegate method to restrict numeric input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow backspace
        if string.isEmpty {
            return true
        }
        
        // Only allow alphabetic characters and spaces for specific fields
        if textField == jobNameTxtField || textField == JobLocationTxtField {
            let allowedCharacterSet = CharacterSet.letters.union(CharacterSet.whitespaces)
            if string.rangeOfCharacter(from: allowedCharacterSet.inverted) != nil {
                return false
            }
        }
        
        return true
    }
}

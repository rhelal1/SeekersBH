//
//  addJobView2ViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class AddJobView2ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var textview2: UITextView!
    @IBOutlet weak var viewv: UIView!
    
    @IBAction func nextbtn(_ sender: UIButton) {
        if validateInput() {
            // Segue handled by storyboard
        }
    }
    
    var job: JobAd? // Receive JobAd object
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textview1.layer.cornerRadius = 10
        textview2.layer.cornerRadius = 10
        viewv.layer.cornerRadius = 10
        
        // Set delegate for text views
        textview1.delegate = self
        textview2.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddJobView4", // Match the storyboard segue identifier
           let destination = segue.destination as? AddJobView4ViewController {
            job?.jobDescription = textview1.text
            job?.jobQualifications = textview2.text
            destination.job = job
        }
    }
    
    // Validation function
    private func validateInput() -> Bool {
        // Check if Job Description is empty
        guard let jobDescription = textview1.text, !jobDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(message: "Job description cannot be empty.")
            return false
        }
        
        // Check if Job Description contains invalid characters
        if containsInvalidCharacters(jobDescription) {
            showAlert(message: "Job description contains invalid characters.")
            return false
        }
        
        // Check if Job Qualifications is empty
        guard let jobQualifications = textview2.text, !jobQualifications.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(message: "Job qualifications cannot be empty.")
            return false
        }
        
        // Check if Job Qualifications contains invalid characters
        if containsInvalidCharacters(jobQualifications) {
            showAlert(message: "Job qualifications contain invalid characters.")
            return false
        }
        
        return true
    }
    
    // Helper function to check for invalid characters
    private func containsInvalidCharacters(_ text: String) -> Bool {
        // Allow letters, spaces, newlines, commas, and periods
        let allowedCharacterSet = CharacterSet.letters.union(.whitespacesAndNewlines).union(CharacterSet(charactersIn: ",."))
        return text.rangeOfCharacter(from: allowedCharacterSet.inverted) != nil
    }
    
    // Alert function
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // UITextViewDelegate to restrict invalid characters during input
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Allow backspace
        if text.isEmpty {
            return true
        }
        
        // Allow letters, spaces, newlines, commas, and periods
        let allowedCharacterSet = CharacterSet.letters.union(.whitespacesAndNewlines).union(CharacterSet(charactersIn: ",."))
        return text.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil
    }
}

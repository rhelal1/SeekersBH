//
//  addJobView4\ViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class AddJobView4ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var textview2: UITextView!
    @IBOutlet weak var viewv: UIView!
    
    var job: JobAd? // Receive JobAd object
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewv.layer.cornerRadius = 10
        textview1.layer.cornerRadius = 10
        textview2.layer.cornerRadius = 10
        
        // Set delegates for text views
        textview1.delegate = self
        textview2.delegate = self
    }
    
    @IBAction func nextbtn(_ sender: UIButton) {
        if validateInput() {
            // Segue handled by storyboard
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddJobView3", // Match the storyboard segue identifier
           let destination = segue.destination as? addJobView3ViewController {
            job?.jobKeyResponsibilites = textview1.text
            job?.jobEmploymentBenfits = textview2.text
            destination.job = job
        }
    }
    
    // Validation function
    private func validateInput() -> Bool {
        // Validate Job Key Responsibilities
        guard let keyResponsibilities = textview1.text, !keyResponsibilities.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(message: "Job key responsibilities cannot be empty.")
            return false
        }
        
        if containsInvalidCharacters(keyResponsibilities) {
            showAlert(message: "Job key responsibilities contain invalid characters.")
            return false
        }
        
        // Validate Employment Benefits
        guard let employmentBenefits = textview2.text, !employmentBenefits.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(message: "Employment benefits cannot be empty.")
            return false
        }
        
        if containsInvalidCharacters(employmentBenefits) {
            showAlert(message: "Employment benefits contain invalid characters.")
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

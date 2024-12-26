//
//  addJobView4ViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class AddJobView4ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var textview2: UITextView!
    @IBOutlet weak var viewv: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var coordinator: AddEditJobCoordinator? // Added coordinator for mode handling
    var job: JobAd? // Receive JobAd object
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewv.layer.cornerRadius = 10
        textview1.layer.cornerRadius = 10
        textview2.layer.cornerRadius = 10
        
        // Set delegates for text views
        textview1.delegate = self
        textview2.delegate = self
        
        setupPage()
        setupKeyboard()
    }
    
    private func setupPage() {
        if let coordinator = coordinator, case .edit(let job) = coordinator.mode {
            setupForEditMode(with: job)
        }
    }
    
    private func setupKeyboard() {
         view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing)))
         
         [UIResponder.keyboardWillShowNotification, UIResponder.keyboardWillHideNotification].forEach { notification in
             NotificationCenter.default.addObserver(forName: notification, object: nil, queue: .main) { [weak self] _ in
                 UIView.animate(withDuration: 0.3) {
                     self?.view.frame.origin.y = notification == UIResponder.keyboardWillShowNotification ? -100 : 0
                 }
             }
         }
     }
    
    
    private func setupForEditMode(with job: JobAd) {
        titleLabel.text = "Edit Job Details"
        populateFields(with: job)
    }
    
    private func populateFields(with job: JobAd) {
        textview1.text = job.jobKeyResponsibilites
        textview2.text = job.jobEmploymentBenfits
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
            destination.coordinator = coordinator // Pass the coordinator to maintain the mode
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
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
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

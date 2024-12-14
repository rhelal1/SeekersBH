//
//  addJobView2ViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class AddJobView2ViewController: UIViewController {
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var textview2: UITextView!
    @IBOutlet weak var viewv: UIView!
    
    @IBAction func nextbtn(_ sender: UIButton) {
        if validateInput() {
                    performSegue(withIdentifier: "toAddJobView4", sender: self) // Proceed if validation passes
                }
    }
    var job: JobAd? // Receive JobAd object
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textview1.layer.cornerRadius = 10
        textview2.layer.cornerRadius = 10
        viewv.layer.cornerRadius = 10
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
            guard let jobDescription = textview1.text, !jobDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                showAlert(message: "Job description cannot be empty.")
                return false
            }
            
            guard let jobQualifications = textview2.text, !jobQualifications.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                showAlert(message: "Job qualifications cannot be empty.")
                return false
            }
            
            return true
        }
        
        // Alert function
        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }


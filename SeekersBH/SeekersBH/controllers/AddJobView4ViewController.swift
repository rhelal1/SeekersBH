//
//  addJobView4\ViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class AddJobView4ViewController: UIViewController {
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var textview2: UITextView!
    @IBOutlet weak var viewv: UIView!
    
    @IBAction func nextbtn(_ sender: UIButton) {
        if validateInput() {
            performSegue(withIdentifier: "toAddJobView3", sender: self) // Proceed only if validation passes
                }
    }
    var job: JobAd? // Receive JobAd object
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewv.layer.cornerRadius = 10
        textview1.layer.cornerRadius = 10
        textview2.layer.cornerRadius = 10
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
           guard let keyResponsibilities = textview1.text, !keyResponsibilities.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
               showAlert(message: "Job key responsibilities cannot be empty.")
               return false
           }
           
           guard let employmentBenefits = textview2.text, !employmentBenefits.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
               showAlert(message: "Employment benefits cannot be empty.")
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


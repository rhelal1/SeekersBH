//
//  NewJobDetailViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 15/12/2024.
//

import UIKit
import Firebase
class NewJobDetailViewController: UIViewController {

    @IBOutlet weak var lblPostedDate: UILabel!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobCompanyName: UILabel!
    @IBOutlet weak var JobDetailsContainer: UIView!
    
    
    // Properties to receive data
    var jobTitle: String!
    var companyName: String!
    var postedDate: String!
    
   
    // Properties for job details to pass to the next view controller
     var location: String!
     var employmentType: String!
     var experience: String!
     var salary: String!
     var jobDescription: String!
     var keyResponsibilities: String!
     var requirements: String!
     var benefits: String!
    
    
    // Firebase Firestore reference
       let db = Firestore.firestore()
       
    // Job ID (Document ID)
       var jobDocumentID: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // If jobDocumentID is set, fetch job details from Firestore
               if let jobID = jobDocumentID {
                   fetchJobDetails(jobID: jobID)
               }
                
            }
    
    
    // Fetch job details from Firestore
    func fetchJobDetails(jobID: String) {
        db.collection("jobs").document(jobID).getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            if let document = document, document.exists {
                let data = document.data()

                // Debugging: Log the entire data
                print("Fetched Document Data: \(String(describing: data))")

                self.jobTitle = data?["jobName"] as? String
                self.companyName = data?["companyName"] as? String
                self.experience = data?["experience"] as? String
                self.postedDate = data?["datePosted"] as? String
                self.location = data?["jobLocation"] as? String
                self.employmentType = data?["jobType"] as? String
                self.salary = data?["jobSalary"] as? String
                self.jobDescription = data?["jobDescription"] as? String
                self.keyResponsibilities = data?["jobKeyResponsibilities"] as? String
                self.requirements = data?["requirements"] as? String
                self.benefits = data?["jobEmploymentBenfits"] as? String

                // Update the UI only after data is fetched
                DispatchQueue.main.async {
                    self.updateUI()
                }
            } else {
                print("Document does not exist")
            }
        }
    }



            
    // Update UI with job details
       func updateUI() {
           // Update the UI elements with the fetched data
                  lblJobTitle.text = jobTitle
                  lblJobCompanyName.text = companyName
           lblPostedDate.text = "Posted on: \(String(describing: postedDate))"
       }

    
    
    
    @IBAction func btnApply(_ sender: Any) {
        performSegue(withIdentifier: "showApplyPage", sender: nil)
    }
    
  
        //to receive data to the new job deatils table view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewJobDetailViewController {
            //destinationVC.jobDocumentID = selectedJobID  // Pass the job document ID to fetch details
        }
    }

}

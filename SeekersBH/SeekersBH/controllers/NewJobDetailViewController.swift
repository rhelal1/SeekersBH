//
//  NewJobDetailViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 15/12/2024.
//

import UIKit

class NewJobDetailViewController: UIViewController {

    @IBOutlet weak var lblPostedDate: UILabel!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobCompanyName: UILabel!
    @IBOutlet weak var JobDetailsContainer: UIView!
    
    
    // Properties to receive data
      var jobTitle: String?
      var companyName: String?
      var postedDate: String?
    
   
   //also Properties to receive data to the new job deatils table view controller
    var location: String?
    var employmentType: String?
    var experience: String?
    var salary: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the job title, company name, and posted date
                if let title = jobTitle {
                    lblJobTitle.text = title
                }
                
                if let company = companyName {
                    lblJobCompanyName.text = company
                }
                
                if let date = postedDate {
                    lblPostedDate.text = "Posted on: \(date)"
                }
                
            }
            
    
    @IBAction func btnApply(_ sender: Any) {
        performSegue(withIdentifier: "showApplyPage", sender: nil)
    }
    
  
        //to receive data to the new job deatils table view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? NewJobDetailTableViewController {
            // Pass data to the container view controller
            destinationVC.location = location
            destinationVC.employmentType = employmentType
            destinationVC.experience = experience
            destinationVC.salary = salary
        }
    }

 

}

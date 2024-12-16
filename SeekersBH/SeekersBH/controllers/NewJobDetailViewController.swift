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
            
    
    
  
    

 

}

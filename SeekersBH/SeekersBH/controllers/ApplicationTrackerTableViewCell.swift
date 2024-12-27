//
//  ApplicationTrackerTableViewCell.swift
//  SeekersBH
//
//  Created by marwa on 27/12/2024.
//

import UIKit

class ApplicationTrackerTableViewCell: UITableViewCell {
    

    @IBOutlet weak var jobName: UILabel!
    
    @IBOutlet weak var jobLocation: UILabel!
    
    @IBOutlet weak var jobType: UILabel!
    
    
    @IBOutlet weak var jobStatus: UILabel!
    
    @IBOutlet weak var appStatus: UILabel!
    
    
    // This function will fetch the data from Firebase and populate the table view cell.
    func configureCell(with jobData: [String: Any]) {
//        if let jobName = jobData["jobName"] as? String {
//            self.jobName.text = jobName
//        } else {
//            self.jobName.text = "N/A"
//        }
//        
//        if let jobLocation = jobData["jobLocation"] as? String {
//            self.jobLocation.text = jobLocation
//        } else {
//            self.jobLocation.text = "N/A"
//        }
//        
//        if let jobType = jobData["jobType"] as? String {
//            self.jobType.text = jobType
//        } else {
//            self.jobType.text = "N/A"
//        }
//        
//        if let jobStatus = jobData["status"] as? String {
//            self.jobStatus.text = jobStatus
//        } else {
//            self.jobStatus.text = "N/A"
//        }
//        
//        if let appStatus = jobData["applicationStatus"] as? String {
//            self.appStatus.text = appStatus
//        } else {
//            self.appStatus.text = "N/A"
//        }
        
        jobName.text = jobData["jobName"] as? String
        jobLocation.text = jobData["jobLocation"] as? String
        jobType.text = jobData["jobType"] as? String
        jobStatus.text = jobData["status"] as? String
        appStatus.text = jobData["applicationStatus"] as? String
        
        // Print the values to check
        print("Job Name: \(jobName.text ?? "N/A")")
        print("Job Location: \(jobLocation.text ?? "N/A")")
        print("Job Type: \(jobType.text ?? "N/A")")
        print("Job Status: \(jobStatus.text ?? "N/A")")
        print("Application Status: \(appStatus.text ?? "N/A")")
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

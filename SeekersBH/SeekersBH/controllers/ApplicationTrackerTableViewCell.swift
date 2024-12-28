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
    
    func configureCell(with jobData: [String: Any]) {
        if let jobNameValue = jobData["jobName"] as? String {
            jobName.attributedText = createBoldTitle("Job Name : ", jobNameValue)
        } else {
            jobName.attributedText = createBoldTitle("Job Name : ", "N/A")
        }
        
        if let jobLocationValue = jobData["jobLocation"] as? String {
            jobLocation.attributedText = createBoldTitle("Job Location : ", jobLocationValue)
        } else {
            jobLocation.attributedText = createBoldTitle("Job Location : ", "N/A")
        }
        
        if let jobTypeValue = jobData["jobType"] as? String {
            jobType.attributedText = createBoldTitle("Job Type : ", jobTypeValue)
        } else {
            jobType.attributedText = createBoldTitle("Job Type : ", "N/A")
        }
        
        if let jobStatusValue = jobData["status"] as? String {
            jobStatus.attributedText = createBoldTitle("Job Status : ", jobStatusValue)
        } else {
            jobStatus.attributedText = createBoldTitle("Job Status : ", "N/A")
        }
        
        if let appStatusValue = jobData["applicationStatus"] as? String {
            appStatus.attributedText = createBoldTitle("Application Status : ", appStatusValue)
        } else {
            appStatus.attributedText = createBoldTitle("Application Status : ", "N/A")
        }
    }
    
    private func createBoldTitle(_ title: String, _ value: String) -> NSAttributedString {
        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        let regularFont = UIFont.systemFont(ofSize: 16)
        
        let attributedString = NSMutableAttributedString(
            string: title,
            attributes: [.font: boldFont]
        )
        attributedString.append(NSAttributedString(
            string: value,
            attributes: [.font: regularFont]
        ))
        return attributedString
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

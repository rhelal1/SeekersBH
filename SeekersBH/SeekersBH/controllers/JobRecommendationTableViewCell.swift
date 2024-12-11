//
//  JobRecommendationTableViewCell.swift
//  SeekersBH
//
//  Created by Duha Hashem on 13/12/2024.
//

import UIKit

class JobRecommendationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobCompany: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblEmploymentType: UILabel!
    @IBOutlet weak var lblExperience: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblMeetsRequirements: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(jobTitle: String, companyName: String, location: String, employmentType: String, experience: String, salary: String, meetsRequirements: Bool) {
        // Set the labels with individual parameters
        lblJobTitle.text = jobTitle
        lblJobCompany.text = companyName
        lblLocation.text = "Location: \(location)"
        lblEmploymentType.text = "Employment type: \(employmentType)"
        lblExperience.text = "Experience: \(experience)"
        lblSalary.text = "Salary: \(salary)"
        
        lblMeetsRequirements.isHidden = !meetsRequirements
        lblMeetsRequirements.text = meetsRequirements ? "You meet the job requirements. Apply now." : ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}

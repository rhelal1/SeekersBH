//
//  JobRecommendationTableViewCell.swift
//  SeekersBH
//
//  Created by Duha Hashem on 13/12/2024.
//

import UIKit

class JobRecommendationTableViewCell: UITableViewCell {

    //card view that hold everythings
    @IBOutlet weak var cardView: UIView!
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
    
    // Configure the cell with data
    func configure(jobTitle: String, companyName: String, location: String, employmentType: String, experience: String, salary: String, meetsRequirements: Bool) {
        lblJobTitle.text = jobTitle
        lblJobCompany.text = companyName
        
        // Apply bold and regular text formatting for Location, Employment Type, Experience, and Salary
        lblLocation.attributedText = getFormattedText(title: "Location:", value: location)
        lblEmploymentType.attributedText = getFormattedText(title: "Employment type:", value: employmentType)
        lblExperience.attributedText = getFormattedText(title: "Experience:", value: experience)
        lblSalary.attributedText = getFormattedText(title: "Salary:", value: salary)
        
        // Set visibility and text for meetsRequirements label
        lblMeetsRequirements.isHidden = !meetsRequirements
        lblMeetsRequirements.text = meetsRequirements ? "You meet the job requirements. Apply now!" : ""
        
        // Apply rounded corners for the card view
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
        
        
        if meetsRequirements {
                    lblMeetsRequirements.layer.cornerRadius = 15 // Adjust this to control the roundness
                    lblMeetsRequirements.layer.masksToBounds = true // Ensures the corners are clipped
                } else {
                    lblMeetsRequirements.layer.cornerRadius = 0 // Remove corner radius if not visible
                    lblMeetsRequirements.layer.masksToBounds = false // Optional: prevent clipping when hidden
                }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    // Helper function to apply bold for titles and regular for values
     func getFormattedText(title: String, value: String) -> NSMutableAttributedString {
         // Create a mutable attributed string with the full text
         let fullText = "\(title) \(value)"
         let attributedString = NSMutableAttributedString(string: fullText)
         
         // Define the range for the title (bold) and the value (regular)
         let titleRange = (fullText as NSString).range(of: title)
         let valueRange = (fullText as NSString).range(of: value)
         
         // Apply bold to the title (Location, Employment type, etc.)
         attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: lblLocation.font.pointSize), range: titleRange)
         
         // Apply regular font to the value (Manama, Full-time, etc.)
         attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: lblLocation.font.pointSize), range: valueRange)
         
         return attributedString
     }

}

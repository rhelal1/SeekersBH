//
//  NewJobDetailTableViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 15/12/2024.
//

import UIKit

class NewJobDetailTableViewController: UITableViewController {

    @IBOutlet weak var cardGeneralInformationSection: UIView!
    
    @IBOutlet weak var lblLocationInGeneralSection: UILabel!
    
    @IBOutlet weak var lblEmploymentTypeInGeneralSection: UILabel!
    
    @IBOutlet weak var lblExperienceInGeneralSection: UILabel!
    
    
    @IBOutlet weak var lblSalaryInGeneralSection: UILabel!
    
    @IBOutlet weak var cardJobDescriptionSection: UIView!
    
    @IBOutlet weak var lblJobDescriptionInJobDescriptionSection: UILabel!
    
    
    @IBOutlet weak var cardKeyResponsibilitiesSection: UIView!
    
    @IBOutlet weak var lblKeyResponsInKeyResponsibilitiesSection: UILabel!
    
    @IBOutlet weak var cardRequirementsSection: UIView!
    
    @IBOutlet weak var lblRequirementsInRequiremntsSection: UILabel!
    
    
    @IBOutlet weak var cardBenefitsSection: UIView!
    
    
    @IBOutlet weak var lblBenefitsInBenefitsSection: UILabel!
    
    // Properties to hold the passed data
        var location: String?
        var employmentType: String?
        var experience: String?
        var salary: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCardViewCorners()
        
        // Apply the formatted data to the labels
        if let location = location {
            lblLocationInGeneralSection.attributedText = getFormattedText(title: "Location:", value: location)
        }
        
        if let employmentType = employmentType {
            lblEmploymentTypeInGeneralSection.attributedText = getFormattedText(title: "Employment Type:", value: employmentType)
        }
        
        if let experience = experience {
            lblExperienceInGeneralSection.attributedText = getFormattedText(title: "Experience:", value: experience)
        }
        
        if let salary = salary {
            lblSalaryInGeneralSection.attributedText = getFormattedText(title: "Salary:", value: salary)
        }
       
    }
    
    //for the shape of card (UIView)
    private func setupCardViewCorners() {
        // Apply corner radius to all card views
        cardGeneralInformationSection?.layer.cornerRadius = 15
        cardJobDescriptionSection?.layer.cornerRadius = 15
        cardKeyResponsibilitiesSection?.layer.cornerRadius = 15
        cardRequirementsSection?.layer.cornerRadius = 15
        cardBenefitsSection?.layer.cornerRadius = 15
    }
    
    
    // Helper function to apply bold for titles and regular for values
     private func getFormattedText(title: String, value: String) -> NSMutableAttributedString {
         // Create a mutable attributed string with the full text
         let fullText = "\(title) \(value)"
         let attributedString = NSMutableAttributedString(string: fullText)
         
         // Define the range for the title (bold) and the value (regular)
         let titleRange = (fullText as NSString).range(of: title)
         let valueRange = (fullText as NSString).range(of: value)
         
         // Apply bold to the title (Location, Employment Type, etc.)
         attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: lblLocationInGeneralSection.font.pointSize), range: titleRange)
         
         // Apply regular font to the value (Manama, Full-time, etc.)
         attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: lblLocationInGeneralSection.font.pointSize), range: valueRange)
         
         return attributedString
     }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 
    }
    
    
    //customize the header's color, font and size
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 20) 
            header.textLabel?.textColor = UIColor(red: 9/255, green: 24/255, blue: 86/255, alpha: 1) // Color #091856
        }
    }


}

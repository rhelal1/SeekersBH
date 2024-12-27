//
//  CVDetailsViewController.swift
//  SeekersBH
//
//  Created by marwa on 21/12/2024.
//

import UIKit

class CVDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var cvDetailsTextView: UITextView!
    @IBOutlet weak var cvNameLabel: UILabel!
    
    
    var cvDetails: (id: String, name: String, createdDate: String, aboutMe: String, certifications: [[String: Any]], email: String, fullName: String, highestDegree: String, phoneNumber: String, skillName: String, university: String, portfolio: String, projects: [(name: String, overview: String, url: String)], certificationsOther: String, projectsOther: String, skillsOther: String, linkedIn: String)?
    
    
    @IBAction func editButtonClicked(_ sender: Any) {
        let editVC = storyboard?.instantiateViewController(withIdentifier: "EditCVViewController") as! EditCVViewController
        
        editVC.cvDetails = cvDetails
        present(editVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable editing for the text view
        cvDetailsTextView.isEditable = false
        
        cvDetailsTextView.font = UIFont(name: "Helvetica", size: 14)
        
        // Set padding for the text view
        cvDetailsTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
        
        cvDetailsTextView.text = "Loading CV details..."
        
        guard let details = cvDetails else {
            cvDetailsTextView.text = "CV details are unavailable. Please go back and try again."
            return
        }
        
        cvNameLabel.text = details.name
        
        
        let formattedDetails = NSMutableAttributedString()
        
        // Add "Full Name" label and info
        let fullNameTitle = NSAttributedString(string: "Full Name:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let fullNameInfo = NSAttributedString(string: "\(details.fullName)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(fullNameTitle)
        formattedDetails.append(fullNameInfo)
        
        // Add "Email" label and info
        let emailTitle = NSAttributedString(string: "Email:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let emailInfo = NSAttributedString(string: "\(details.email)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(emailTitle)
        formattedDetails.append(emailInfo)
        
        // Add "Phone Number" label and info
        let phoneNumberTitle = NSAttributedString(string: "Phone Number:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let phoneNumberInfo = NSAttributedString(string: "\(details.phoneNumber)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(phoneNumberTitle)
        formattedDetails.append(phoneNumberInfo)
        
        // Add "LinkedIn" label and info
        let linkedinTitle = NSAttributedString(string: "LinkedIn:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        
        let linkedinInfo = NSAttributedString(string: "\(details.linkedIn)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        
        formattedDetails.append(linkedinTitle)
        formattedDetails.append(linkedinInfo)
        
        // Add "Portfolio" label and info
        let portfolioTitle = NSAttributedString(string: "Portfolio:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let portfolioInfo = NSAttributedString(string: "\(details.portfolio)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(portfolioTitle)
        formattedDetails.append(portfolioInfo)
        
        
        // Add "About Me" label and info
        let aboutMeTitle = NSAttributedString(string: "About Me:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let aboutMeInfo = NSAttributedString(string: "\(details.aboutMe)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(aboutMeTitle)
        formattedDetails.append(aboutMeInfo)
        
        
        // Add "Highest Degree" label and info
        let highestDegreeTitle = NSAttributedString(string: "Highest Degree:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let highestDegreeInfo = NSAttributedString(string: "\(details.highestDegree)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(highestDegreeTitle)
        formattedDetails.append(highestDegreeInfo)
        
        // Add "University" label and info
        let universityTitle = NSAttributedString(string: "University:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let universityInfo = NSAttributedString(string: "\(details.university)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(universityTitle)
        formattedDetails.append(universityInfo)
        
        // Add "Skills" label and info
        let skillsTitle = NSAttributedString(string: "Skills:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let skillsInfo = NSAttributedString(string: "\(details.skillName)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(skillsTitle)
        formattedDetails.append(skillsInfo)
        // Add "Other Skills" section
        let skillsOtherTitle = NSAttributedString(string: "Other Skills:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let skillsOtherInfo = NSAttributedString(string: "\(details.skillsOther)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(skillsOtherTitle)
        formattedDetails.append(skillsOtherInfo)
        
        
        
        // Add "Certifications" section
        let certificationsTitle = NSAttributedString(string: "Certifications:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(certificationsTitle)
        for cert in details.certifications {
            let certNameTitle = NSAttributedString(string: "Certification Name:\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                .paragraphStyle: createParagraphStyle()
            ])
            let certNameInfo = NSAttributedString(string: "\(cert["certificationName"] as? String ?? "N/A")\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: createParagraphStyle()
            ])
            formattedDetails.append(certNameTitle)
            formattedDetails.append(certNameInfo)
            
            
            let certOrgTitle = NSAttributedString(string: "Organization:\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                .paragraphStyle: createParagraphStyle()
            ])
            let certOrgInfo = NSAttributedString(string: "\(cert["certificationIssuingOrganization"] as? String ?? "N/A")\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: createParagraphStyle()
            ])
            formattedDetails.append(certOrgTitle)
            formattedDetails.append(certOrgInfo)
            
            let certDateTitle = NSAttributedString(string: "Date Obtained:\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                .paragraphStyle: createParagraphStyle()
            ])
            let certDateInfo = NSAttributedString(string: "\(cert["certificationDateObtained"] as? String ?? "N/A")\n\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: createParagraphStyle()
            ])
            formattedDetails.append(certDateTitle)
            formattedDetails.append(certDateInfo)
        }
        let certificationsOtherTitle = NSAttributedString(string: "Other Certifications:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        let certificationsOtherInfo = NSAttributedString(string: "\(details.certificationsOther)\n\n", attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(certificationsOtherTitle)
        formattedDetails.append(certificationsOtherInfo)
        
        // Add "Projects" section
        let projectsTitle = NSAttributedString(string: "Projects:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .paragraphStyle: createParagraphStyle()
        ])
        formattedDetails.append(projectsTitle)
        for project in details.projects {
            let projectTitle = NSAttributedString(string: "Project Name:\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                .paragraphStyle: createParagraphStyle()
            ])
            let projectInfo = NSAttributedString(string: "\(project.name)\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: createParagraphStyle()
            ])
            formattedDetails.append(projectTitle)
            formattedDetails.append(projectInfo)
            
            let projectOverviewTitle = NSAttributedString(string: "Overview:\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                .paragraphStyle: createParagraphStyle()
            ])
            let projectOverviewInfo = NSAttributedString(string: "\(project.overview)\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: createParagraphStyle()
            ])
            formattedDetails.append(projectOverviewTitle)
            formattedDetails.append(projectOverviewInfo)
            
            let projectUrlTitle = NSAttributedString(string: "Project URL:", attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                .paragraphStyle: createParagraphStyle()
            ])
            let projectUrlInfo = NSAttributedString(string: "\(project.url)\n\n", attributes: [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: createParagraphStyle()
            ])
            formattedDetails.append(projectUrlTitle)
            formattedDetails.append(projectUrlInfo)
            
            // Add "Other Projects" section
            let projectsOtherTitle = NSAttributedString(string: "Other Projects:\n", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 18),
                .paragraphStyle: createParagraphStyle()
            ])
            let projectsOtherInfo = NSAttributedString(string: "\(details.projectsOther)\n\n", attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .paragraphStyle: createParagraphStyle()
            ])
            formattedDetails.append(projectsOtherTitle)
            formattedDetails.append(projectsOtherInfo)
            
            // Add "Created Date" label and info
            let createdDateTitle = NSAttributedString(string: "Created Date:\n", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 18),
                .paragraphStyle: createParagraphStyle()
            ])
            let createdDateInfo = NSAttributedString(string: "\(details.createdDate)\n\n", attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .paragraphStyle: createParagraphStyle()
            ])
            formattedDetails.append(createdDateTitle)
            formattedDetails.append(createdDateInfo)
        }
        
        cvDetailsTextView.attributedText = formattedDetails
    }
    
    func createParagraphStyle() -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.paragraphSpacing = 6
        paragraphStyle.alignment = .left
        paragraphStyle.headIndent = 0
        return paragraphStyle
    }
}

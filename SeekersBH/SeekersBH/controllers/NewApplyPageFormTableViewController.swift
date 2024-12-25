//
//  NewApplyPageFormTableViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 16/12/2024.
//

import UIKit


// Delegate protocol for sending data to ApplyPageViewController
protocol JobApplicationDelegate: AnyObject {
    func didFinishFillingForm(jobApplication: JobApplication)
}


class NewApplyPageFormTableViewController: UITableViewController {
    
    

    // Outlets for text fields inside static table view
    
    @IBOutlet weak var FullNametxt: UITextField!
    
    @IBOutlet weak var Emailtxt: UITextField!
    @IBOutlet weak var PhoneNumbertxt: UITextField!
    
    @IBOutlet weak var Addresstxt: UITextField!
    
    @IBOutlet weak var JobTitletxt: UITextField!
    
    @IBOutlet weak var CompanyNametxt: UITextField!
    
    @IBOutlet weak var EmploymentDatestxt: UITextField!
    
    @IBOutlet weak var JobResponsibilitiestxt: UITextField!
    
    @IBOutlet weak var Degreetxt: UITextField!
    
    @IBOutlet weak var UniversitySchoolNametxt: UITextField!
    
    @IBOutlet weak var GraduationDatetxt: UITextField!
    
    @IBOutlet weak var TechnicalSkillstxt: UITextField!
    
    @IBOutlet weak var Certificationstxt: UITextField!
    
    @IBOutlet weak var LanguageProficiencytxt: UITextField!
    
    
    @IBOutlet weak var ReferenceNametxt: UITextField!
    
    @IBOutlet weak var ReferenceContactInformationtxt: UITextField!
    
    @IBOutlet weak var AnswerQuestion1txt: UITextField!
    
    
    @IBOutlet weak var AnswerQuestion2txt: UITextField!
    
    
    @IBOutlet weak var AnswerQuestion3txt: UITextField!
    
    // Declare the delegate to send data to ApplyPageViewController
       weak var delegate: JobApplicationDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Allow the table view to automatically adjust row height
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
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
    
    
    
    
    
    // Collect form data and return as JobApplication object
        func collectFormData() -> JobApplication? {
            // Collect and trim form data
            let fullName = FullNametxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let email = Emailtxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let phoneNumber = PhoneNumbertxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let address = Addresstxt.text?.trimmingCharacters(in: .whitespaces)  // Optional
            let jobTitle = JobTitletxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let companyName = CompanyNametxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let employmentDateString = EmploymentDatestxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let jobResponsibilities = JobResponsibilitiestxt.text?.trimmingCharacters(in: .whitespaces)  // Optional
            let degree = Degreetxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let universityName = UniversitySchoolNametxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let graduationDateString = GraduationDatetxt.text?.trimmingCharacters(in: .whitespaces) ?? ""

            // Convert dates to Date objects
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let employmentDate = dateFormatter.date(from: employmentDateString)
            let graduationDate = dateFormatter.date(from: graduationDateString)

            // Skills, certifications, and languages (split into arrays)
            let skills = TechnicalSkillstxt.text?.trimmingCharacters(in: .whitespaces).split(separator: ",").map { String($0) } ?? []
            let certifications = Certificationstxt.text?.trimmingCharacters(in: .whitespaces).split(separator: ",").map { String($0) } ?? []
            let languages = LanguageProficiencytxt.text?.trimmingCharacters(in: .whitespaces).split(separator: ",").map { String($0) } ?? []

            // References and additional questions
            let referenceName = ReferenceNametxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let referenceContact = ReferenceContactInformationtxt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let answer1 = AnswerQuestion1txt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let answer2 = AnswerQuestion2txt.text?.trimmingCharacters(in: .whitespaces) ?? ""
            let answer3 = AnswerQuestion3txt.text?.trimmingCharacters(in: .whitespaces) ?? ""

            // Validation (if any required fields are empty)
            if fullName.isEmpty || email.isEmpty || phoneNumber.isEmpty || jobTitle.isEmpty || companyName.isEmpty ||
                employmentDate == nil || degree.isEmpty || universityName.isEmpty || graduationDate == nil {
                showAlert(message: "Please fill in all the required fields.")
                return nil
            }

            // Create and return JobApplication object
            let jobApplication = JobApplication(
                fullName: fullName,
                email: email,
                phoneNumber: phoneNumber,
                address: address,
                workExperince: WorkExperince(
                    jobTitle: jobTitle,
                    companyName: companyName,
                    employmentDate: employmentDate ?? Date(),
                    jobResponsibilites: jobResponsibilities
                ),
                education: Education(
                    dgree: degree,
                    insinuation: universityName,
                    graduationDate: graduationDate ?? Date()
                ),
                qualifications: Qualification(
                    skill: skills,
                    certifications: certifications,
                    languages: languages
                ),
                reference: Reference(
                    name: referenceName,  // Pass the string to the Reference struct
                    contactDetails: referenceContact  // Pass the string to the Reference struct
                ),
                additionalQuestions: [
                    "Question1": answer1,
                    "Question2": answer2,
                    "Question3": answer3
                ], uploadCV: nil // Don't include the CV field
                 
            )

            return jobApplication
        }

     
        
    // Show alert if any field is missing
       func showAlert(message: String) {
           let alert = UIAlertController(title: "Missing Information", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
        
    
         


}

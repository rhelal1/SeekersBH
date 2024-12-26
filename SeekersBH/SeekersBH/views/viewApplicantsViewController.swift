//
//  viewApplicantsViewController.swift
//  SeekersBH
//
//  Created by BP-36-224-10 on 25/12/2024.
//

import UIKit

class viewApplicantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var applicants: [JobApplication] = []
    @IBOutlet weak var viewApplicants: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create some sample applications
//              applicants = [
//                  JobApplication(fullName: "John Doe", email: "john@example.com", phoneNumber: "123-456-7890", address: "123 Main St",
//                                 workExperince: WorkExperince(jobTitle: "Software Engineer", companyName: "Tech Corp", employmentDate: Date(), jobResponsibilites: "Developing software"),
//                                 education: Education(dgree: .bachelor, insinuation: .computerScience, graduationDate: Date()),
//                                 likedInURL: "https://linkedin.com/in/johndoe", protofolioURL: "https://johndoeportfolio.com", aboutMe: "Passionate software engineer with 5 years of experience.",
//                                 educations: nil, skills: nil, certifications: [], projectSecions: [], qualifications: nil, reference: nil, additionalQuestions: nil, uploadCV: CV()),
//                  JobApplication(fullName: "Jane Smith", email: "jane@example.com", phoneNumber: "987-654-3210", address: "456 Elm St",
//                                 workExperince: WorkExperince(jobTitle: "Project Manager", companyName: "Biz Inc", employmentDate: Date(), jobResponsibilites: "Managing projects"),
//                                 education: Education(dgree: .master, insinuation: .businessAdmin, graduationDate: Date()),
//                                 likedInURL: "https://linkedin.com/in/janesmith", protofolioURL: "https://janesmithportfolio.com", aboutMe: "Experienced project manager with a focus on Agile methodologies.",
//                                 educations: nil, skills: nil, certifications: [], projectSecions: [], qualifications: nil, reference: nil, additionalQuestions: nil, uploadCV: CV())
//              ]
              
              viewApplicants.delegate = self
              viewApplicants.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return applicants.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "applicantCell", for: indexPath) as! applicantCellTableViewCell
           
           let applicant = applicants[indexPath.row]
           
           cell.applicantName.text = applicant.fullName
           cell.workexperence.text = applicant.workExperince?.jobTitle
           cell.Appstatus.text = "Status: Pending"  // For now, hardcoding as Pending
           cell.appDate.text = DateFormatter.localizedString(from: applicant.workExperince?.employmentDate ?? Date(), dateStyle: .short, timeStyle: .short)
           
           return cell
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

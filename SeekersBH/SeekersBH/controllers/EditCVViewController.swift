//
//  EditCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 26/12/2024.
//

import FirebaseFirestore
import UIKit

class EditCVViewController: UIViewController {
    var cvDetails: (id: String, name: String, createdDate: String, aboutMe: String, certifications: [[String: Any]], email: String, fullName: String, highestDegree: String, phoneNumber: String, skillName: String, university: String, portfolio: String, projects: [(name: String, overview: String, url: String)], certificationsOther: String, projectsOther: String, skillsOther: String, linkedIn: String)?
    
    var editFieldsTableVC: EditCVFieldsTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let embeddedVC = self.children.first(where: { $0 is EditCVFieldsTableViewController }) {
            editFieldsTableVC = (embeddedVC as! EditCVFieldsTableViewController)
        }
        
        editFieldsTableVC.editFullName.text = cvDetails?.fullName
        editFieldsTableVC.editEmail.text = cvDetails?.email
        editFieldsTableVC.editPhoneNumber.text = cvDetails?.phoneNumber
        editFieldsTableVC.editLinkedIn.text = cvDetails?.linkedIn
        editFieldsTableVC.editPortfolio.text = cvDetails?.portfolio
        editFieldsTableVC.editCvName.text = cvDetails?.name
        editFieldsTableVC.editAboutMe.text = cvDetails?.aboutMe
        editFieldsTableVC.editDegree.text = cvDetails?.highestDegree
        editFieldsTableVC.editUniversity.text = cvDetails?.university
        editFieldsTableVC.editSkills.text = cvDetails?.skillName
        editFieldsTableVC.editOtherSkills.text = cvDetails?.skillsOther
        editFieldsTableVC.editCertName.text = cvDetails?.certifications.first?["certificationName"] as? String
        editFieldsTableVC.editCertDate.text = cvDetails?.certifications.first?["certificationDateObtained"] as? String
        editFieldsTableVC.editCertOrg.text = cvDetails?.certifications.first?["certificationIssuingOrganization"] as? String
        editFieldsTableVC.editOtherCert.text = cvDetails?.certificationsOther
        editFieldsTableVC.EditProjectName.text = cvDetails?.projects.first?.name
        editFieldsTableVC.editProjectURL.text = cvDetails?.projects.first?.url
        editFieldsTableVC.editProjectOverview.text = cvDetails?.projects.first?.overview
        editFieldsTableVC.editOtherProjects.text = cvDetails?.projectsOther
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let updatedCVData: [String: Any] = [
            "fullName": editFieldsTableVC.editFullName.text ?? "",
            "email": editFieldsTableVC.editEmail.text ?? "",
            "phoneNumber": editFieldsTableVC.editPhoneNumber.text ?? "",
            "linkenIn": editFieldsTableVC.editLinkedIn.text ?? "",
            "portfolio": editFieldsTableVC.editPortfolio.text ?? "",
            "cvName": editFieldsTableVC.editCvName.text ?? "",
            "aboutMe": editFieldsTableVC.editAboutMe.text ?? "",
            "highestDegree": editFieldsTableVC.editDegree.text ?? "",
            "university": editFieldsTableVC.editUniversity.text ?? "",
            "skillName": editFieldsTableVC.editSkills.text ?? "",
            "otherSkill": editFieldsTableVC.editOtherSkills.text ?? "",
            "certifications": [
                [
                    "certificationName": editFieldsTableVC.editCertName.text ?? "",
                    "certificationDateObtained": editFieldsTableVC.editCertDate.text ?? "",
                    "certificationIssuingOrganization": editFieldsTableVC.editCertOrg.text ?? ""
                ]
            ],
            "otherCertification": editFieldsTableVC.editOtherCert.text ?? "",
            "projectName": editFieldsTableVC.EditProjectName.text ?? "",
            "projectOverview": editFieldsTableVC.editProjectOverview.text ?? "",
            "projectURL": editFieldsTableVC.editProjectURL.text ?? "",
            "otherProjects": editFieldsTableVC.editOtherProjects.text ?? "",
        ]
        
        let db = Firestore.firestore()
        db.collection("CV").document(cvDetails!.id).setData(updatedCVData, merge: true) { error in
            if let error = error {
                print("Error updating CV: \(error.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

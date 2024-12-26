//
//  CertificationCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import UIKit

class CertificationCVViewController: UIViewController {
    
    
    @IBOutlet weak var certificationName: UITextField!
    @IBOutlet weak var certificationDateObtained: UITextField!
    @IBOutlet weak var certificationIssuingOrganization: UITextField!
    @IBOutlet weak var otherCertification: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        if certificationName.text?.isEmpty ?? true {
            showAlert(message: "Certification name cannot be empty.")
            return
        }
        
        if certificationDateObtained.text?.isEmpty ?? true {
            showAlert(message: "Certification date obtained cannot be empty.")
            return
        }
        
        
        guard let certificationDateString = certificationDateObtained.text,
              let certificationDate = isValidDate(certificationDateString) else {
            showAlert(message: "Please enter a valid date in MM/DD/YYYY format.")
            return
        }
        
        if certificationDate > Date() {
            showAlert(message: "Certification date cannot be in the future.")
            return
        }
        
        if certificationIssuingOrganization.text?.isEmpty ?? true {
            showAlert(message: "Certification issuing organization cannot be empty.")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let formattedDate = dateFormatter.string(from: certificationDate)
        
        let newCertification = Certification(
            name: certificationName.text ?? "",
            DateObtained: certificationDate,
            IssuingOrganization: certificationIssuingOrganization.text ?? ""
        )
        
        // printing just to make sure it is saved
        print("Saved Certification: \(newCertification.name), Date Obtained: \(formattedDate), Issuing Organization: \(newCertification.IssuingOrganization)")
        
        CVManager.shared.cv.certifications.append(newCertification)
        
        CVManager.shared.cv.otherCertification = otherCertification.text ?? ""
        // printing just to make sure it is saved
        print("Saved other certifications: \(CVManager.shared.cv.otherCertification)")
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    func isValidDate(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.date(from: dateString)
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

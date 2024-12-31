
import UIKit

class CertificateManageViewController: UIViewController {

    var certificate : CourseCertification!
    // Variable to store the selected CV
    var selectedCV: CVInfo?
    
    @IBOutlet weak var certificateName: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var cvSelection: UIButton!
    @IBOutlet weak var viewInfo: UIView!
    
    @IBAction func addToCVButton(_ sender: Any) {
        guard let selectedCV = selectedCV else {
               // Show alert if no CV is selected
               showAlert(title: "Error", message: "No CV selected")
               return
           }

           // Get the selected CV ID
           let cvID = selectedCV.id
           
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm" // Format for date and time
        
           // Prepare the new certification data (replace these with real data)
           let newCertification = [
            "certificationName": certificate.title, // Certification name
               "certificationDateObtained": dateFormatter.string(from: currentDate),
               "certificationIssuingOrganization": "SeekersBH" // Issuing organization
           ]
           
           // Add the new certification to the selected CV
           Task {
               do {
                   // Fetch the current certifications of the selected CV
                   var certifications = try await CourseManager.share.fetchCertifications(forCVID: cvID)
                   
                   // Add the new certification to the certifications array
                   certifications.append(newCertification)
                   
                   // Update the certifications in Firestore
                   CourseManager.share.updateCertifications(forCVID: cvID, certifications: certifications) { error in
                       if let error = error {
                           // Show alert if there's an error during the update
                           self.showAlert(title: "Error", message: "Failed to add certification: \(error.localizedDescription)")
                       } else {
                           // Show success alert
                           self.showAlert(title: "Success", message: "Certification added successfully!")
                       }
                   }
               } catch {
                   // Show alert if there's an error fetching certifications
                   self.showAlert(title: "Error", message: "Failed to fetch certifications: \(error.localizedDescription)")
               }
           }
    }
    
    // Alert function
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func removeCertificate(_ sender: Any) {
        CourseManager.share.removeCertificateFromFirebase(withID: certificate.id) { [weak self] error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
                        
            // Show an alert in the view controller for failure
            let alert = UIAlertController(title: "Error", message: "Failed to remove certificate", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                        
                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                }
                    } else {
                        // Show an alert in the view controller
                        let alert = UIAlertController(title: "Success", message: "Certificate removed successfully", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                        alert.addAction(okAction)
                        
                    }
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInfo.layer.cornerRadius = 15
        viewInfo.layer.masksToBounds = true
        
        certificateName.text = certificate.title
        score.text = "Score: \(certificate.score)%"
        date.text = "Obtained on: " + certificate.extractDateTimeString()
        
        Task {
            do {
                let userCVs = try await CourseManager.share.fetchTheUserCVs(forUserID: AccessManager.userID!)
                if userCVs.count > 0 {
                    // Create UIAction for each CVInfo
                    let actions = userCVs.map { cv in
                        UIAction(title: cv.name) { _ in
                            // Update the button's title when an option is selected
                            self.cvSelection.setTitle(cv.name, for: .normal)
                            self.selectedCV = cv
                        }
                    }
                    
                    // Create the menu with the actions
                    let menu = UIMenu(children: actions)
                    
                    // Assign the menu to the button
                    cvSelection.menu = menu
                    cvSelection.showsMenuAsPrimaryAction = true // Automatically show the menu when tapped
                
                    } else {
                        // Handle the case where cvNames is empty
                        self.cvSelection.setTitle("No CVs available", for: .normal)
                        self.cvSelection.menu = nil // Clear the menu if there are no CVs
                        // Optionally, you might want to show an alert or a message to the user
                    }
            } catch {
                print("Error fetching CV names: \(error.localizedDescription)")
            }
        }
    }


}

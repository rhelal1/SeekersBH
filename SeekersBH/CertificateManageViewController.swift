
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
        // Create the alert controller
            let alertController = UIAlertController(
                title: "Confirm Deletion",
                message: "Are you sure you want to remove this certificate?",
                preferredStyle: .alert
            )
            
            // Add a "Cancel" action
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            // Add a "Delete" action
            alertController.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                Task {
                    do {
                        let success = try await CourseManager.share.removeCertificateFromFirebase(withID: self.certificate.id)
                        if success {
                            self.showAlert(title: "Success", message: "Certificate removed successfully")
                        }
                    } catch {
                        self.showAlert(title: "Error", message: "Failed to remove certificate")
                    }
                }
                self.returnBack() // Call returnBack only after deletion is attempted
            })
            
            // Present the alert
            present(alertController, animated: true, completion: nil)
    }
    
    func returnBack() {
        // Instantiate the CertificationsViewController
            if let certificationsVC = storyboard?.instantiateViewController(withIdentifier: "CertificationsViewController") as? CertificationsViewController {
                
                // Get the current view controller stack
                var viewControllers = navigationController?.viewControllers ?? []
                
                // Check if there are at least two view controllers in the stack
                if viewControllers.count >= 2 {
                    // Remove the last two view controllers (the current one and the one before it)
                    viewControllers.removeLast(2)
                } else {
                    // If there are less than two, just remove all and add CertificationsViewController
                    viewControllers.removeAll()
                }
                
                // Add the CertificationsViewController to the stack
                viewControllers.append(certificationsVC)
                
                // Set the new view controller stack
                navigationController?.setViewControllers(viewControllers, animated: true)
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

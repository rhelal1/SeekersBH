//
//  CVSelectionJobApplicationViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 25/12/2024.
//

import UIKit
import Firebase
class CVSelectionJobApplicationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    
    // Property to hold the job application data passed from the previous view
    var tempJobApplication: JobApplication?
    
    
    @IBOutlet weak var dropDrownView: UIView!
    
    @IBOutlet weak var selectCvbtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // Data source for CVs
    var cvList: [String] = []
    
    var isTableViewVisible = false
    
    var selectedCV: String? // To store the selected CV
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchCVsFromFirebase()
    }
    
    // Setup initial UI
      func setupUI() {
          dropDrownView.layer.cornerRadius = 15
          dropDrownView.layer.borderWidth = 0
          tableView.isHidden = true
          tableView.delegate = self
          tableView.dataSource = self
      }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cvList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showcvsdrop", for: indexPath)
                let cvName = cvList[indexPath.row]
                cell.textLabel?.text = cvName
                print("Cell at row \(indexPath.row) set with CV name: \(cvName)")
                return cell
    }
    
    // Table View Row Selection
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedCV = cvList[indexPath.row]
              self.selectedCV = selectedCV
              selectCvbtn.setTitle(selectedCV, for: .normal)
              tableView.isHidden = true
              isTableViewVisible = false
              print("Selected CV: \(selectedCV)")
       }
    
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        
        guard let tempJobApplication = tempJobApplication else {
               showAlert(message: "No previous information found.")
               return
           }

           guard let selectedCV = selectedCV else {
               showAlert(message: "Please select a CV before applying.")
               return
           }

           saveJobApplicationToFirebase(jobApplication: tempJobApplication, selectedCV: selectedCV)
        
    }
    
    
    // Function to save the job application to Firebase
    func saveJobApplicationToFirebase(jobApplication: JobApplication, selectedCV: String) {
        let db = Firestore.firestore()

        // Combine the job application data with the selected CV
        let jobApplicationData: [String: Any] = [
            "fullName": jobApplication.fullName,
            "email": jobApplication.email,
            "phoneNumber": jobApplication.phoneNumber,
            "address": jobApplication.address ?? "",
            "workExperince": [
                "jobTitle": jobApplication.workExperince?.jobTitle ?? "Not provided",
                "companyName": jobApplication.workExperince?.companyName ?? "Not provided",
                "employmentDate": jobApplication.workExperince?.employmentDate != nil ?
                Timestamp(date: jobApplication.workExperince!.employmentDate) :
                    FieldValue.serverTimestamp(), // Save server time if nil
                "jobResponsibilities": jobApplication.workExperince?.jobResponsibilites ?? "Not provided"
            ],
            "education": [
                "degree": jobApplication.education?.dgree ?? "Not provided",
                "institution": jobApplication.education?.insinuation ?? "Not provided",
                "graduationDate": jobApplication.education?.graduationDate != nil ?
                Timestamp(date: jobApplication.education!.graduationDate) :
                    FieldValue.serverTimestamp() // Save server time if nil
            ],
            "qualifications": [
                "skills": jobApplication.qualifications?.skill ?? [],
                "certifications": jobApplication.qualifications?.certifications ?? [],
                "languages": jobApplication.qualifications?.languages ?? []
            ],
            "reference": [
                "name": jobApplication.reference?.name ?? "Not provided",
                "contactDetails": jobApplication.reference?.contactDetails ?? "Not provided"
            ],
            "additionalQuestions": jobApplication.additionalQuestions ?? [:],
            "uploadCV": selectedCV
        ]

        // Add the job application to Firebase
        db.collection("JobApplication").addDocument(data: jobApplicationData) { error in
            if let error = error {
                print("Error saving job application: \(error.localizedDescription)")
                self.showAlert(message: "Failed to apply. Please try again. Error: \(error.localizedDescription)")
            } else {
                print("Job application saved successfully!")
                self.showAlertWithCompletion(message: "Your application has been submitted successfully.") {
                    // Action after user clicks "Done"
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    
    
    
    func showAlertWithCompletion(message: String, completion: @escaping () -> Void) {
          let alert = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Done", style: .default) { _ in
              completion()
          })
          present(alert, animated: true, completion: nil)
      }
    
    // Show alert
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
    @IBAction func toggleDropdownMenu(_ sender: Any) {
        isTableViewVisible.toggle()
               tableView.isHidden = !isTableViewVisible
               print("Dropdown toggled. TableView is now \(isTableViewVisible ? "visible" : "hidden")")
        
    }
    
    // Fetch CVs from Firebase
    func fetchCVsFromFirebase() {
        guard let userID = AccessManager.userID else {
            print("Error: User ID not found.")
            return
        }
        let db = Firestore.firestore()

        db.collection("CV").whereField("userID", isEqualTo: userID).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching CVs: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents, !documents.isEmpty else {
                print("No CVs found for userID: \(userID)")
                return
            }

            self.cvList = documents.compactMap { $0["cvName"] as? String }
            print("Fetched CVs: \(self.cvList)")

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

        
      
        
        
    }



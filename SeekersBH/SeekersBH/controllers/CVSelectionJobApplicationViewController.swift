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
    var cvList: [String] = [] // Replace String with your CV model if necessary
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
                cell.textLabel?.text = cvList[indexPath.row]
                return cell
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
                "employmentDate": Timestamp(date: jobApplication.workExperince?.employmentDate ?? Date()),
                "jobResponsibilities": jobApplication.workExperince?.jobResponsibilites ?? ""
            ],
            "education": [
                "degree": jobApplication.education?.dgree ?? "Not provided",
                "institution": jobApplication.education?.insinuation ?? "Not provided",
                "graduationDate": Timestamp(date: jobApplication.education?.graduationDate ?? Date())
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
                        self.showAlert(message: "Failed to apply. Please try again.")
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
        
    }
    
    // Fetch CVs from Firebase
     func fetchCVsFromFirebase() {
         guard let userID = AccessManager.userID else { return }
         let db = Firestore.firestore()

         db.collection("CV").whereField("userID", isEqualTo: userID).getDocuments { snapshot, error in
             if let error = error {
                 print("Error fetching CVs: \(error.localizedDescription)")
                 return
             }

             self.cvList = snapshot?.documents.compactMap { $0["cvName"] as? String } ?? []
             self.tableView.reloadData()
         }
     }

        
      
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedCV = cvList[indexPath.row]
            selectCvbtn.setTitle(selectedCV, for: .normal)
            tableView.isHidden = true
            isTableViewVisible = false
        }
    }



//
//  AllCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 20/12/2024.
//

import UIKit
import FirebaseFirestore

class AllCVViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var cvTableView: UITableView!
    
    var cvList: [(id: String, name: String, createdDate: String)] = []
    var cvDetails: (id: String, name: String, createdDate: String, aboutMe: String, certifications: [[String: Any]], email: String, fullName: String, highestDegree: String, phoneNumber: String, skillName: String, university: String, portfolio: String, projects: [(name: String, overview: String, url: String)], certificationsOther: String, projectsOther: String, skillsOther: String, linkedIn: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvTableView.delegate = self
        cvTableView.dataSource = self
        
        fetchCVs()
    }
    
    func fetchCVs() {
        let db = Firestore.firestore()
        db.collection("CV").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching CVs: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.cvList = documents.compactMap { document in
                let data = document.data()
                let cvName = data["cvName"] as? String ?? "Unnamed CV"
                let createdDate = (data["createdDate"] as? Timestamp)?.dateValue() ?? Date()
                
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                let formattedDate = formatter.string(from: createdDate)
                
                return (id: document.documentID, name: cvName, createdDate: formattedDate)
            }
            
            DispatchQueue.main.async {
                self.cvTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cvList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CVCell", for: indexPath) as? CVTableViewCell else {
            fatalError("Unable to dequeue CVCell")
        }
        
        let cv = cvList[indexPath.row]
        cell.cvName.text = cv.name
        cell.cvDate.text = cv.createdDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCV = cvList[indexPath.row]
        self.cvDetails = nil
        
        let loadingAlert = UIAlertController(title: nil, message: "Loading CV details...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingAlert.view.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: loadingAlert.view.centerXAnchor).isActive = true
        loadingIndicator.bottomAnchor.constraint(equalTo: loadingAlert.view.bottomAnchor, constant: -20).isActive = true
        loadingIndicator.startAnimating()
        present(loadingAlert, animated: true, completion: nil)
        
        fetchCVDetails(cvID: selectedCV.id) { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                loadingIndicator.stopAnimating()
                loadingAlert.dismiss(animated: true) {
                    if self.cvDetails != nil {
                        // Manually perform the segue
                        self.performSegue(withIdentifier: "showCVDetails", sender: self)
                    } else {
                        // Show an error if details are unavailable
                        let errorAlert = UIAlertController(title: "Error", message: "CV details are unavailable. Please try again.", preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(errorAlert, animated: true)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCVDetails" {
            if let detailsVC = segue.destination as? CVDetailsViewController {
                detailsVC.cvDetails = self.cvDetails
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cvDetails = nil
    }
    
    func fetchCVDetails(cvID: String, completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        db.collection("CV").document(cvID).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching CV details: \(error.localizedDescription)")
                return
            }
            
            guard let data = snapshot?.data() else { return }
            
            let certifications = data["certifications"] as? [[String: Any]] ?? []
            _ = data["certificationsOther"] as? String ?? "N/A"
            let projectNames = data["projectName"] as? [String] ?? []
            let projectOverviews = data["projectOverview"] as? [String] ?? []
            let projectURLs = data["projectURL"] as? [String] ?? []
            _ = data["projectsOther"] as? String ?? "N/A"
            let skillName = data["skillName"] as? String ?? "N/A"
            _ = data["skillsOther"] as? String ?? "N/A"
            var projects: [(name: String, overview: String, url: String)] = []
            for i in 0..<min(projectNames.count, projectOverviews.count, projectURLs.count) {
                projects.append((name: projectNames[i], overview: projectOverviews[i], url: projectURLs[i]))
            }
            
            self.cvDetails = (
                id: cvID,
                name: data["cvName"] as? String ?? "Unnamed CV",
                createdDate: self.formatDateToString(date: (data["createdDate"] as? Timestamp)?.dateValue() ?? Date()),
                aboutMe: data["aboutMe"] as? String ?? "N/A",
                certifications: certifications,
                email: data["email"] as? String ?? "N/A",
                fullName: data["fullName"] as? String ?? "N/A",
                highestDegree: data["highestDegree"] as? String ?? "N/A",
                phoneNumber: data["phoneNumber"] as? String ?? "N/A",
                skillName: skillName,
                university: data["university"] as? String ?? "N/A",
                portfolio: data["portfolio"] as? String ?? "N/A",
                projects: projects,
                certificationsOther: data["otherCertification"] as? String ?? "N/A",
                projectsOther: data["otherProjects"] as? String ?? "N/A",
                skillsOther: data["otherSkill"] as? String ?? "N/A",
                linkedIn: data["linkenIn"] as? String ?? "N/A"
            )
            
            completion()
        }
    }
    
    func formatDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}



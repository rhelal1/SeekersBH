//
//  ManageJobsViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//
import UIKit
import FirebaseCore
import FirebaseFirestore

class ManageJobsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    private var visibleJobs: [JobAd] = []
    private var allJobs: [JobAd] = []
    
    var isShowingHidden = false
    
    @IBOutlet weak var jobsTable: UITableView!
    
    @IBOutlet weak var toggleJobsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchJobs()
    }
    @IBAction func didTapToggle(_ sender: Any) {
        isShowingHidden.toggle()
           toggleJobsButton.setTitle(isShowingHidden ? "Hide Hidden" : "Show Hidden", for: .normal)
           updateVisibleJobs()
    }
    
    private func setupTableView() {
        jobsTable.delegate = self
        jobsTable.dataSource = self
        jobsTable.separatorStyle = .none
        jobsTable.rowHeight = 188
        jobsTable.estimatedRowHeight = 188
    }
    
    private func fetchJobs() {
        let db = FirebaseManager.shared.db
           let jobsRef = db.collection("jobs")
           
           jobsRef.order(by: "datePosted", descending: true).getDocuments { [weak self] snapshot, error in
               guard let self = self else { return }
               if let error = error {
                   self.showAlert(message: "Error fetching jobs: \(error.localizedDescription)")
                   return
               }
               
               guard let documents = snapshot?.documents else {
                   self.visibleJobs.removeAll()
                   self.allJobs.removeAll()
                   self.jobsTable.reloadData()
                   return
               }
               
               self.allJobs = documents.compactMap { self.createJobAd(from: $0) }
               self.updateVisibleJobs()
           }
        

    }
    
    private func updateVisibleJobs() {
        if isShowingHidden {
            visibleJobs = allJobs.filter { $0.isHidden }
        } else {
            visibleJobs = allJobs.filter { !$0.isHidden }
        }
        jobsTable.reloadData()
    }
    
    
    private func createJobAd(from document: QueryDocumentSnapshot) -> JobAd? {
        let data = document.data()
        
        
        let jobName = data["jobName"] as? String ?? ""
        let jobLocation = data["jobLocation"] as? String ?? ""
        let datePosted = (data["datePosted"] as? Timestamp)?.dateValue() ?? Date()
        let jobStatus = data["status"] as? String == "Closed" ? JobStatus.Closed : JobStatus.Open
        let jobHidden = data["isHidden"] as? Bool ?? false
        
        return JobAd(
            documentId: document.documentID,
            jobName: jobName,
            jobLocation: jobLocation,
            datePosted: datePosted,
            status: jobStatus,
            isHidden: jobHidden
        )
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "adminJobCell") as? AdminJobCell else {
            return UITableViewCell()
        }
        
        let job = visibleJobs[indexPath.row]
        if let documentId = job.documentId {
            cell.setupCell(
                jobName: job.jobName,
                jobLocation: job.jobLocation,
                date: job.datePosted,
                status: job.status,
                isHidden: job.isHidden,
                documentId: documentId
            )
        } else {
            print("Warning: Missing document ID for job at index \(indexPath.row)")
        }
        return cell
    }
    
    func updateJobVisibility(documentId: String, isHidden: Bool) {
        if let index = allJobs.firstIndex(where: { $0.documentId == documentId }) {
            allJobs[index].isHidden = isHidden
            updateVisibleJobs()
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

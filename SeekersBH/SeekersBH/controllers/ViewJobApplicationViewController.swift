//
//  ViewJobApplicationViewController.swift
//  SeekersBH
//
//  Created by BP-36-201-18 on 09/12/2024.
//

import UIKit
import FirebaseFirestore

class ViewJobApplicationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!

    private var jobs: [JobAd] = []
    private var filteredJobs: [JobAd] = []
    private var allJobs: [JobAd] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchJobs()
    }
    
    private func setupTableView() {
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        jobsTableView.separatorStyle = .none
        
        // Set row height
        jobsTableView.rowHeight = 188  // Adjust this value as needed
        jobsTableView.estimatedRowHeight = 188
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshJobs), for: .valueChanged)
        jobsTableView.refreshControl = refreshControl
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search jobs..."
    }
    
    @objc private func refreshJobs() {
        fetchJobs()
    }
    
    private func fetchJobs() {
        // Start refresh animation
        jobsTableView.refreshControl?.beginRefreshing()
        
        // Get database reference
        let db = FirebaseManager.shared.db
        
        // Get collection reference
        let jobsRef = db.collection("jobs")
        
        // Create query
        let query = jobsRef.order(by: "datePosted", descending: true)
        
        // Define completion handler separately
        let completion: (QuerySnapshot?, Error?) -> Void = { [weak self] snapshot, error in
            self?.handleFetchCompletion(snapshot: snapshot, error: error)
        }
        
        // Execute query
        query.getDocuments(completion: completion)
    }

    private func handleFetchCompletion(snapshot: QuerySnapshot?, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Stop refresh animation
            self.jobsTableView.refreshControl?.endRefreshing()
            
            // Handle error if exists
            if let error = error {
                self.showAlert(message: "Error fetching jobs: \(error.localizedDescription)")
                return
            }
            
            // Handle empty snapshot
            guard let documents = snapshot?.documents else {
                self.jobs.removeAll()
                self.allJobs.removeAll()
                self.jobsTableView.reloadData()
                return
            }
            
            // Process documents
            self.processDocuments(documents)
        }
    }

    private func processDocuments(_ documents: [QueryDocumentSnapshot]) {
        // Process each document separately
        let fetchedJobs = documents.compactMap { document in
            return createJobAd(from: document)
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.jobs = fetchedJobs
            self.allJobs = fetchedJobs
            self.updateJobStatuses()
            self.jobsTableView.reloadData()
        }
    }
    
    private func updateJobStatuses() {
        let currentDate = Date()
        let db = FirebaseManager.shared.db
        let group = DispatchGroup()
        
        for (index, job) in jobs.enumerated() {
            // Check if job deadline has passed and status isn't already Closed
            if job.jobApplicationDeadline < currentDate && job.status != .Closed {
                // Update local array
                jobs[index].status = .Closed
                
                // Update in Firebase if we have documentId
                if let documentId = job.documentId {
                    group.enter()
                    
                    // Update in Firestore
                    db.collection("jobs").document(documentId).updateData([
                        "status": JobStatus.Closed
                    ]) { [weak self] error in
                        if let error = error {
                            print("Error updating job status: \(error.localizedDescription)")
                            
                            // Optionally show alert on error
                            DispatchQueue.main.async {
                                self?.showAlert(message: "Error updating job status: \(error.localizedDescription)")
                            }
                        }
                        group.leave()
                    }
                }
            }
        }
        
        // When all updates are complete, reload the table
        group.notify(queue: .main) { [weak self] in
            self?.jobsTableView.reloadData()
        }
    }
    private func createJobAd(from document: QueryDocumentSnapshot) -> JobAd? {
        let data = document.data()
        
        // Extract basic string values
        let jobName = data["jobName"] as? String ?? ""
        let jobLocation = data["jobLocation"] as? String ?? ""
        let jobDescription = data["jobDescription"] as? String ?? ""
        let keyResponsibilities = data["jobKeyResponsibilites"] as? String ?? ""
        let qualifications = data["jobQualifications"] as? String ?? ""
        let salary = data["jobSalary"] as? String ?? ""
        let benefits = data["jobEmploymentBenfits"] as? String ?? ""
        let perks = data["additionalPerks"] as? [String] ?? []
        
        // Convert timestamps
        let datePosted = (data["datePosted"] as? Timestamp)?.dateValue() ?? Date()
        let deadline = (data["jobApplicationDeadline"] as? Timestamp)?.dateValue() ?? Date()
        
        // Handle JobType (has raw value)
        let jobTypeString = data["jobType"] as? String ?? ""
        let jobType: JobType
        switch jobTypeString {
            case "Full Time": jobType = .fullTime
            case "Part Time": jobType = .partTime
            case "Contract": jobType = .contract
            case "Temporary": jobType = .temporary
            default: jobType = .fullTime
        }
        
        // Handle JobStatus (no raw value)
        let statusString = data["status"] as? String ?? ""
        let status: JobStatus = statusString.lowercased() == "closed" ? .Closed : .Open
        
        // Handle ApplicationStatus (no raw value)
        let appStatusString = data["applicationStatus"] as? String ?? ""
        let appStatus: ApplicationStatus
        switch appStatusString.lowercased() {
            case "underreview": appStatus = .underReview
            case "shortlisted": appStatus = .shortlisted
            case "interviewscheduled": appStatus = .interviewScheduled
            default: appStatus = .pending
        }
        
        return JobAd(
            documentId: document.documentID,
            jobName: jobName,
            jobLocation: jobLocation,
            jobType: jobType,
            jobDescription: jobDescription,
            jobKeyResponsibilites: keyResponsibilities,
            jobQualifications: qualifications,
            jobSalary: salary,
            jobEmploymentBenfits: benefits,
            additionalPerks: perks,
            jobApplicationDeadline: deadline,
            applicants: [], // Empty array since your JobAd expects [JobApplication]
            datePosted: datePosted,
            status: status,
            applicationStatus: appStatus
        )
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBar.text?.isEmpty == false ? filteredJobs.count : jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobPostCell") as? jobCellTableViewCell else {
            return UITableViewCell()
        }
        
        let job = searchBar.text?.isEmpty == false ? filteredJobs[indexPath.row] : jobs[indexPath.row]
        cell.setupCell(jobName: job.jobName,
                      date: job.datePosted,
                      Status: job.status,
                      numOfApplications: job.applicants.count)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowJobDetails",
           let detailsVC = segue.destination as? JobDetailsViewController,
           let indexPath = jobsTableView.indexPathForSelectedRow {
            let selectedJob = searchBar.text?.isEmpty == false ? filteredJobs[indexPath.row] : jobs[indexPath.row]
            detailsVC.selectedJob = selectedJob
        }
    }
    
    // MARK: - Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredJobs = jobs
        } else {
            filteredJobs = jobs.filter { job in
                return job.jobName.lowercased().contains(searchText.lowercased()) ||
                       job.jobLocation.lowercased().contains(searchText.lowercased())
            }
        }
        jobsTableView.reloadData()
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Filter Jobs", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All Jobs", style: .default) { [weak self] _ in
            self?.jobs = self?.allJobs ?? []
            self?.jobsTableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Open Jobs", style: .default) { [weak self] _ in
            self?.jobs = self?.allJobs.filter { $0.status == .Open } ?? []
            self?.jobsTableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Closed Jobs", style: .default) { [weak self] _ in
            self?.jobs = self?.allJobs.filter { $0.status == .Closed } ?? []
            self?.jobsTableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        present(alert, animated: true)
    }
}

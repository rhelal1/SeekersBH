import UIKit

class JobDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedJob: JobAd? // Pass this from the previous screen
    @IBOutlet weak var jobDetailsTableView: UITableView!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the table view delegate and data source
        jobDetailsTableView.delegate = self
        jobDetailsTableView.dataSource = self
        
        // Enable dynamic cell height
        jobDetailsTableView.rowHeight = UITableView.automaticDimension
        jobDetailsTableView.estimatedRowHeight = 44 // Set an estimated height
        
        // Set job title and company name
        jobTitleLabel.text = selectedJob?.jobName ?? "Unknown Job"
        companyNameLabel.text = "Company Name" // Replace with actual company name if available
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewApplicantsButtonTapped(_ sender: UIButton) {
        // Handle view applications button action
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard let selectedJob = selectedJob else {
            // Show an error message if the job object is missing
            showAlert(message: "Failed to load job details for editing.")
            return
        }
        // Navigate to the edit page
        performSegue(withIdentifier: "editJob", sender: selectedJob)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        // Ensure a job is selected
        guard let selectedJob = selectedJob else {
            showAlert(message: "No job selected to delete.")
            return
        }
        
        // Present a confirmation alert to the user
        let alertController = UIAlertController(title: "Delete Job",
                                                message: "Are you sure you want to delete this job? This action cannot be undone.",
                                                preferredStyle: .alert)
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Delete action
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteJob(job: selectedJob)
        }
        
        // Add actions to the alert controller
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    private func deleteJob(job: JobAd) {
        // Safely unwrap documentId
        guard let documentId = job.documentId else {
            self.showAlert(message: "Job document ID is missing.")
            return
        }

        // Optionally, show a loading indicator here

        FirebaseManager.shared.deleteDocument(collectionName: "jobs", documentId: documentId) { error in
            DispatchQueue.main.async {
                // Optionally, hide the loading indicator here

                if let error = error {
                    self.showAlert(message: "Failed to delete job: \(error.localizedDescription)")
                } else {
                    self.showAlert(title:"Success", message: "Job deleted successfully.") {
                        // Navigate back to the previous screen
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editJob",
           let destination = segue.destination as? TestViewController,
           let job = sender as? JobAd {
            destination.job = job
            // Initialize coordinator with .edit mode and the job to edit
            destination.coordinator = AddEditJobCoordinator(mode: .edit(job: job))
        }
        if segue.identifier == "toViewApplicants",
           let destination = segue.destination as? viewApplicantsViewController{
            destination.selectedJob = selectedJob
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6 // General Info, Description, Qualifications, Responsibilities, Benefits, Perks
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4 // General Info
        case 1: return 1 // Description
        case 2: return 1 // Qualifications
        case 3: return 1 // Responsibilities
        case 4: return 1 // Benefits
        case 5: return selectedJob?.additionalPerks.count ?? 0 // Perks
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailsCell", for: indexPath) as? JobDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        // Populate the cell content based on the section and row
        switch indexPath.section {
        case 0: // General Information
            switch indexPath.row {
            case 0: cell.contentLabel.text = "Location: \(selectedJob?.jobLocation ?? "N/A")"
            case 1: cell.contentLabel.text = "Type: \(selectedJob?.jobType.rawValue.capitalized ?? "N/A")"
            case 2: cell.contentLabel.text = "Salary: \(selectedJob?.jobSalary ?? "N/A")"
            case 3: cell.contentLabel.text = "Status: \(selectedJob?.status == .Open ? "Open" : "Closed")"
            default: break
            }
        case 1: // Description
            cell.contentLabel.text = selectedJob?.jobDescription ?? "N/A"
        case 2: // Qualifications
            cell.contentLabel.text = selectedJob?.jobQualifications ?? "N/A"
        case 3: // Responsibilities
            cell.contentLabel.text = selectedJob?.jobKeyResponsibilites ?? "N/A"
        case 4: // Benefits
            cell.contentLabel.text = selectedJob?.jobEmploymentBenfits ?? "N/A"
        case 5: // Additional Perks
            cell.contentLabel.text = selectedJob?.additionalPerks[indexPath.row] ?? "N/A"
        default: break
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor(hex: "#091856")
        titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        headerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "General Information"
        case 1: return "Description"
        case 2: return "Qualifications/Skills"
        case 3: return "Responsibilities"
        case 4: return "Employment Benefits"
        case 5: return "Additional Perks"
        default: return nil
        }
    }
    
    // MARK: - Private Methods
    
    private func showAlert(title: String = "Error", message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

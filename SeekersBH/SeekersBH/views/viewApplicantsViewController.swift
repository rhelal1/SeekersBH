import UIKit
import FirebaseFirestore

class viewApplicantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - Properties
    var applicants: [Applicant] = []
    var filteredApplicants: [Applicant] = []
    var selectedJob: JobAd?
    
    // MARK: - Outlets
    @IBOutlet weak var viewApplicants: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchApplicants()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // TableView setup
        viewApplicants.delegate = self
        viewApplicants.dataSource = self
        viewApplicants.separatorStyle = .none
        
        // SearchBar setup
        searchBar.delegate = self
        searchBar.placeholder = "Search applicants..."
        
        // Add refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshApplicants), for: .valueChanged)
        viewApplicants.refreshControl = refreshControl
    }
    
    // MARK: - Data Fetching
    private func fetchApplicants() {
        guard (selectedJob?.documentId) != nil else { return }
        
        viewApplicants.refreshControl?.beginRefreshing()
        
        let db = FirebaseManager.shared.db
        let applicantsRef = db.collection("applicants")
            //.whereField("jobId", isEqualTo: jobId)
        
        applicantsRef.getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.viewApplicants.refreshControl?.endRefreshing()
                
                if let error = error {
                    self.showAlert(message: "Error fetching applicants: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.applicants = []
                    self.viewApplicants.reloadData()
                    return
                }
                
                self.applicants = documents.compactMap { document in
                    return self.createJobApplication(from: document)
                }
                
                self.filteredApplicants = self.applicants
                self.viewApplicants.reloadData()
            }
        }
    }
    
    @objc private func refreshApplicants() {
        fetchApplicants()
    }
    
    // MARK: - TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBar.text?.isEmpty == false ? filteredApplicants.count : applicants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "applicantCell", for: indexPath) as? applicantCellTableViewCell else {
            return UITableViewCell()
        }
        
        let applicant = searchBar.text?.isEmpty == false ? filteredApplicants[indexPath.row] : applicants[indexPath.row]
        
        cell.applicantName.text = applicant.applicantName
        cell.Appstatus.text = applicant.status
        
        if let date = applicant.applicationDate {
            cell.appDate.text = "Applied: \(DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none))"
        }
        
        return cell
    }
    
    // MARK: - SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredApplicants = applicants
        } else {
            filteredApplicants = applicants.filter { applicant in
                return applicant.applicantName.lowercased().contains(searchText.lowercased())
            }
        }
        viewApplicants.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Filter Applicants", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All Applicants", style: .default) { [weak self] _ in
            self?.filteredApplicants = self?.applicants ?? []
            self?.viewApplicants.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Pending", style: .default) { [weak self] _ in
            self?.filteredApplicants = self?.applicants.filter { $0.status == "Pending" } ?? []
            self?.viewApplicants.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Under Review", style: .default) { [weak self] _ in
            self?.filteredApplicants = self?.applicants.filter { $0.status == "Under Review" } ?? []
            self?.viewApplicants.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Shortlisted", style: .default) { [weak self] _ in
            self?.filteredApplicants = self?.applicants.filter { $0.status == "Short listed" } ?? []
            self?.viewApplicants.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        present(alert, animated: true)
    }
    
    // MARK: - Helper Methods
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func createJobApplication(from document: QueryDocumentSnapshot) -> Applicant? {
        let data = document.data()
        
        guard let applicantName = data["applicantName"] as? String,
              let applicationDate = data["applicationDate"] as? Timestamp,
              let specialization = data["specialization"] as? String,
              let jobId = data["jobId"] as? String
                else {
            return nil
        }
        
        return Applicant(
            id: document.documentID,
            applicantName: applicantName,
            applicationDate: applicationDate.dateValue(),
            specialization: specialization,
            jobId: jobId
        )
    }

}

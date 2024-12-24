import UIKit

class JobDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedJob: JobAd? // Pass this from the previous screen
    @IBOutlet weak var jobDetailsTableView:UITableView!
    
    @IBAction func deleteBtn(_ sender: Any) {
        // Handle delete button action
    }
     
    @IBAction func editBtn(_ sender: Any) {
        guard let selectedJob = selectedJob else {
            // Show an error message if the job object is missing
            showAlert(message: "Failed to load job details for editing.")
            return
        }
        // Navigate to the edit page
       performSegue(withIdentifier: "toAddJobView1", sender: selectedJob)
    }
    
    @IBAction func ViewAppbtn(_ sender: Any) {
        // Handle view applications button action
    }
    
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var companyNamelbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the table view delegate and data source
        jobDetailsTableView.delegate = self
        jobDetailsTableView.dataSource = self
        
        // Enable dynamic cell height
        jobDetailsTableView.rowHeight = UITableView.automaticDimension
        jobDetailsTableView.estimatedRowHeight = 44 // Set an estimated height
        
        // Set job title and company name
        jobTitle.text = selectedJob?.jobName ?? "Unknown Job"
        companyNamelbl.text = "Company Name" // Replace with actual company name if available

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddJobView1",
           let destination = segue.destination as? TestViewController,
           let job = sender as? JobAd {
            destination.job = job
            // Initialize coordinator with .edit mode and the job to edit
            destination.coordinator = AddEditJobCoordinator(mode: .edit(job: job))
        }
    }
    
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
    
    // Customize the header view for each section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white // Adjust background color if needed

        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20) // Increase font size and make it bold
        headerLabel.textColor = UIColor(hex: "#091856") // Use the custom color
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        // Adjust the headerLabel frame to add some spacing
        headerLabel.frame = CGRect(x: 10, y: -5, width: tableView.frame.size.width - 20, height: 30) // Move it up by adjusting the y value (negative value)

        headerView.addSubview(headerLabel)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailsCell", for: indexPath) as? JobDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        // Populate the cell content based on the section and row
        switch indexPath.section {
        case 0: // General Information
            switch indexPath.row {
            case 0: cell.contentlbl.text = "Location: \(selectedJob?.jobLocation ?? "N/A")"
            case 1: cell.contentlbl.text = "Type: \(selectedJob?.jobType.rawValue.capitalized ?? "N/A")"
            case 2: cell.contentlbl.text = "Salary: \(selectedJob?.jobSalary ?? "N/A")"
            case 3: cell.contentlbl.text = "Status: \(selectedJob?.status == .Open ? "Open" : "Closed")"
            default: break
            }
        case 1: // Description
            cell.contentlbl.text = selectedJob?.jobDescription ?? "N/A"
        case 2: // Qualifications
            cell.contentlbl.text = selectedJob?.jobQualifications ?? "N/A"
        case 3: // Responsibilities
            cell.contentlbl.text = selectedJob?.jobKeyResponsibilites ?? "N/A"
        case 4: // Benefits
            cell.contentlbl.text = selectedJob?.jobEmploymentBenfits ?? "N/A"
        case 5: // Additional Perks
            cell.contentlbl.text = selectedJob?.additionalPerks[indexPath.row] ?? "N/A"
        default: break
        }
        
        return cell
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
          

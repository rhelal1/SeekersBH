//
//  JobDetails2ViewController.swift
//  SeekersBH
//
//  Created by BP-36-224-16 on 26/12/2024.
//

import UIKit

class JobDetails2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetails2Cell", for: indexPath) as? JobDetailsTableViewCell else {
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

}

//
//  NewJobRecommendationViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 15/12/2024.
//

import UIKit

class NewJobRecommendationViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // Initialize the jobRecommendations array
    var jobRecommendations = [JobRecommendation]()  // Initialize it as an empty array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate and datasource for table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        // Append job recommendations to the array
        jobRecommendations.append(JobRecommendation(jobTitle: "Software Engineer", companyName: "TechCorp", location: "Manama", employmentType: "Full-time", experience: "2+ years", salary: "800-1000 per month", meetsRequirements: false))
        
        jobRecommendations.append(JobRecommendation(jobTitle: "UI/UX Designer", companyName: "DesignPro", location: "Hamad Town", employmentType: "part-time", experience: "5+ years", salary: "800 per month", meetsRequirements: true))
        
        jobRecommendations.append(JobRecommendation(jobTitle: "Data Analyst", companyName: "DataWorld", location: "Aali", employmentType: "Full-time", experience: "10+ years", salary: "450-600 per month", meetsRequirements: true))
        
        // Reload the table view to display the data
        tableView.reloadData()
    }

    // TableView DataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobRecommendations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobRecCell", for: indexPath) as! NewJobRecommendationTableViewCell
        let data = jobRecommendations[indexPath.row]
        
        // Configure the cell with job data
        cell.configure(jobTitle: data.jobTitle, companyName: data.companyName, location: data.location, employmentType: data.employmentType, experience: data.experience, salary: data.salary, meetsRequirements: data.meetsRequirements)
        
        return cell
    }

    // Prepare  for the segue to NewJobDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showJobDetail" {  // Ensure your segue identifier is correct
            if let indexPath = tableView.indexPathForSelectedRow {
                let jobData = jobRecommendations[indexPath.row]
                let destinationVC = segue.destination as! NewJobDetailViewController
                
                // Pass job title and company name
                destinationVC.jobTitle = jobData.jobTitle
                destinationVC.companyName = jobData.companyName
                
                
               
                
                
                // Optionally set the posted date (hardcoded for now)
                destinationVC.postedDate = "Dec 15, 2024"
            }
        }
    }
    
    
    
}

// JobRecommendation struct
struct JobRecommendation {
    let jobTitle: String
    let companyName: String
    let location: String
    let employmentType: String
    let experience: String
    let salary: String
    let meetsRequirements: Bool
}

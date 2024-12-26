//
//  JobRecommendationViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 13/12/2024.
//

import UIKit

class JobRecommendationViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var tabelView: UITableView!
    var jobRecommendations = [JobRecommendation]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.rowHeight = UITableView.automaticDimension
        
        jobRecommendations.append(JobRecommendation(jobTitle: "Software Engineer", companyName: "TechCorp", location: "Manama", employmentType: "Full-time", experience: "2+ years", salary: "800-1000 per month", meetsRequirements: false))
                
                jobRecommendations.append(JobRecommendation(jobTitle: "UI/UX Designer", companyName: "DesignPro", location: "Hamad Town", employmentType: "part-time", experience: "5+ years", salary: "800 per month", meetsRequirements: true))
                
                jobRecommendations.append(JobRecommendation(jobTitle: "Data Analyst", companyName: "DataWorld", location: "Aali", employmentType: "Full-time", experience: "10+ years", salary: "450-600 per month", meetsRequirements: true))

        
        tabelView.reloadData()
    }
    
    
 
 

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobRecommendations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobRecCell", for: indexPath) as! JobRecommendationTableViewCell
                let data = jobRecommendations[indexPath.row]
        
        cell.configure(jobTitle: data.jobTitle, companyName: data.companyName, location: data.location, employmentType: data.employmentType, experience: data.experience, salary: data.salary, meetsRequirements: data.meetsRequirements)
        
        return cell
    }
}



struct JobRecommendation {
        let jobTitle: String
        let companyName: String
        let location: String
        let employmentType: String
        let experience: String
        let salary: String
        let meetsRequirements: Bool
    }

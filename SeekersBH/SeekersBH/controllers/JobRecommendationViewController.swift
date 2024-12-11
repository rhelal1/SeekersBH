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
        
        jobRecommendations.append(JobRecommendation.init(jobTitle: "Software Engineer", companyName: "TechCorp", location: "Manama", employmentType: "Full-time", experience: "2+ years", salary: "800-1000 per month", meetsRequirements: false))
        
        jobRecommendations.append(JobRecommendation.init(jobTitle: "UI/UX Designer", companyName: "DesignPro", location: "Manama", employmentType: "Full-time", experience: "2+ years", salary: "800-1000 per month", meetsRequirements: false))
        
               jobRecommendations.append(JobRecommendation.init(jobTitle: "Data Analyst", companyName: "DataWorld", location: "Manama", employmentType: "Full-time", experience: "2+ years", salary: "800-1000 per month", meetsRequirements: true))

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

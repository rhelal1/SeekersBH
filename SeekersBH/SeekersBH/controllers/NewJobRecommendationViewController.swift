//
//  NewJobRecommendationViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 15/12/2024.
//

import UIKit
import Firebase

class NewJobRecommendationViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var jobRecommendations = [JobAd]()
        private let db = Firestore.firestore() // Firestore instance

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate and datasource for table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        // Ensure userID is available using guard let
            guard let userID = AccessManager.userID else {
                print("User ID is not available")
                return
            }
            
            // Fetch job recommendations based on the user's interests
            fetchJobRecommendations(forUserID: userID)
    }
    
    // Function to fetch job recommendations for a specific user
    func fetchJobRecommendations(forUserID userID: String) {
        // Assuming you have a "Interest" collection in Firestore
        db.collection("Interest")
            .document(userID)
            .getDocument { [weak self] (document, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching interests: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document, document.exists else {
                    print("No interests document found for user")
                    return
                }
                
                // Fetch interests (assuming it's an array of strings)
                if let interests = document.data()?["interest1"] as? String {
                    // Now fetch jobs based on the interest
                    self.fetchJobs(forInterests: interests, userID: userID)
                } else {
                    print("No interests found in document")
                }
            }
    }

    
    // Function to fetch jobs based on interests
    func fetchJobs(forInterests interests: Any, userID: String) {
        // If interests is a single string, convert it to an array for compatibility
        let interestArray: [String]
        if let interest = interests as? String {
            interestArray = [interest]  // Convert single interest to an array
        } else if let interestList = interests as? [String] {
            interestArray = interestList  // Use the array of interests directly
        } else {
            print("Invalid interest data format")
            return
        }
        
        // Query jobs that match the user's interest(s)
        db.collection("jobs")
            .whereField("interestFor", in: interestArray) // Check if 'interestFor' matches any of the interests
            .getDocuments { [weak self] (snapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching jobs: \(error.localizedDescription)")
                    return
                }
                
                var recommendations = [JobAd]()
                
                snapshot?.documents.forEach { document in
                    let data = document.data()
                    
                    // Create job ad with fetched data
                    let jobAd = JobAd(
                        documentId: document.documentID,
                        jobName: data["jobName"] as? String ?? "",
                        jobLocation: data["jobLocation"] as? String ?? "",
                        jobType: JobType(rawValue: data["jobType"] as? String ?? "") ?? .fullTime,
                        jobDescription: data["jobDescription"] as? String ?? "",
                        jobKeyResponsibilites: data["jobKeyResponsibilities"] as? String ?? "",
                        jobQualifications: data["jobQualifications"] as? String ?? "",
                        jobSalary: data["jobSalary"] as? String ?? "",
                        jobEmploymentBenfits: data["jobEmploymentBenefits"] as? String ?? "",
                        additionalPerks: data["additionalPerks"] as? [String] ?? [],
                        jobApplicationDeadline: (data["jobApplicationDeadline"] as? Timestamp)?.dateValue() ?? Date(),
                        applicants: data["applicants"] as? [JobApplication] ?? [],
                        datePosted: (data["datePosted"] as? Timestamp)?.dateValue() ?? Date(),
                        status: .Open, // Assuming status is Open for simplicity
                        applicationStatus: .pending, // Assuming applicationStatus is pending by default
                        isHidden: data["isHidden"] as? Bool ?? false
                    )
                    
                    recommendations.append(jobAd)
                }
                
                self.jobRecommendations = recommendations // Replace existing recommendations with filtered ones
                self.tableView.reloadData()
            }
    }








       
    
    
    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobRecommendations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobRecCell", for: indexPath) as! NewJobRecommendationTableViewCell
        let data = jobRecommendations[indexPath.row]
        
        // Configure the cell with job data
        cell.configure(
            jobTitle: data.jobName,
            companyName: data.jobLocation,
            location: data.jobLocation,
            employmentType: data.jobType.rawValue,
            experience: data.jobQualifications,
            salary: data.jobSalary
        )
        
        return cell
    }
    

    // Prepare  for the segue to NewJobDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showJobDetail" {  // Ensure your segue identifier is correct
             if let indexPath = tableView.indexPathForSelectedRow {
                 let jobData = jobRecommendations[indexPath.row]
                 let destinationVC = segue.destination as! NewJobDetailViewController
                 
                 // Pass job title and company name
                 destinationVC.jobTitle = jobData.jobName
                 destinationVC.companyName = jobData.jobLocation
                 
                 // Pass additional data for NewJobDetailTableViewController
                 destinationVC.location = jobData.jobLocation
                 destinationVC.employmentType = jobData.jobType.rawValue
                 destinationVC.experience = jobData.jobQualifications
                 destinationVC.salary = jobData.jobSalary
                 
                 // Convert the postedDate to a string, assuming it's a Date type in jobData
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateStyle = .medium  // You can customize this as needed
                 dateFormatter.timeStyle = .none
                 let formattedDate = dateFormatter.string(from: jobData.datePosted)
                 
                 // Pass the formatted date to the destination view controller
                 destinationVC.postedDate = formattedDate
             }
         }
     }
    
    
    
}


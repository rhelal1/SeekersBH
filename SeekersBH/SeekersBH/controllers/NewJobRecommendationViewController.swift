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
        
        // Ensure userID is available
                guard let userID = AccessManager.userID else {
                    print("User ID is not available")
                    return
            }
            
        // Fetch user data (role and interes
        fetchUserData(forUserID: userID)
    }
    
    // Function to fetch user data (role and interests)
        func fetchUserData(forUserID userID: String) {
            db.collection("User")
                .document(userID)
                .getDocument { [weak self] (document, error) in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error fetching user data: \(error.localizedDescription)")
                        return
                    }

                    guard let document = document, document.exists else {
                        print("No user document found for userID \(userID)")
                        return
                    }

                    let data = document.data()!
                    let role = data["role"] as? String ?? "NormalUser" // Default to "NormalUser" if role is not set

                    // Proceed based on the user's role
                    self.fetchJobsBasedOnRole(role: role, userID: userID)
                }
        }
    
    // Function to fetch jobs based on role
    func fetchJobsBasedOnRole(role: String, userID: String) {
        switch role {
        case "NormalUser":
            fetchUserInterests(forUserID: userID)
        case "Guest", "Admin":
            fetchAllJobs()
        default:
            print("Unknown role: \(role)")
        }
    }
    
    // Function to fetch jobs based on user interests
    func fetchUserInterests(forUserID userID: String) {
        db.collection("Interest")
            .whereField("userID", isEqualTo: userID)
            .getDocuments { [weak self] (snapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching interests: \(error.localizedDescription)")
                    return
                }

                guard let snapshot = snapshot, !snapshot.documents.isEmpty else {
                    print("No interests document found for user")
                    return
                }

                // Assuming only one document per user in the "Interest" collection
                let document = snapshot.documents.first!
                let data = document.data()

                // Extract all interest fields (assuming they follow the naming convention `interestX`)
                let interests = data.compactMap { key, value in
                    key.starts(with: "interest") ? value as? String : nil
                }

                if interests.isEmpty {
                    print("No interests found in document")
                    return
                }

                print("User interests: \(interests)") // Debug: Log all user interests
                self.fetchJobs(forInterests: interests)
            }
    }
    
    
    // Function to fetch jobs based on interests
    func fetchJobs(forInterests interests: [String]) {
        let dispatchGroup = DispatchGroup()
        var recommendations = [JobAd]()

        for interest in interests {
            print("Fetching jobs for interest: \(interest)") // Debug: Log interest being queried
            dispatchGroup.enter()

            db.collection("jobs")
                .whereField("interestFor", isEqualTo: interest)
                .getDocuments { [weak self] (snapshot, error) in
                    guard self != nil else { return }

                    if let error = error {
                        print("Error fetching jobs for interest \(interest): \(error.localizedDescription)")
                        dispatchGroup.leave()
                        return
                    }

                    guard let snapshot = snapshot else {
                        print("No snapshot returned for interest: \(interest)")
                        dispatchGroup.leave()
                        return
                    }

                    snapshot.documents.forEach { document in
                        let data = document.data()
                        print("Job found for interest \(interest): \(data)") // Debug: Log job data

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
                            status: .Open,
                            applicationStatus: .pending,
                            isHidden: data["isHidden"] as? Bool ?? false
                        )

                        recommendations.append(jobAd)
                    }

                    dispatchGroup.leave()
                }
        }

        dispatchGroup.notify(queue: .main) {
            self.jobRecommendations = recommendations
            print("Total jobs fetched: \(self.jobRecommendations.count)") // Debug: Log total jobs
            self.tableView.reloadData()
        }
    }

    // Function to fetch all jobs (for Guest and Admin roles)
    func fetchAllJobs() {
        db.collection("jobs")
            .getDocuments { [weak self] (snapshot, error) in
                guard let self = self else { return }

                if let error = error {
                    print("Error fetching all jobs: \(error.localizedDescription)")
                    return
                }

                guard let snapshot = snapshot else {
                    print("No jobs found")
                    return
                }

                var recommendations = [JobAd]()
                snapshot.documents.forEach { document in
                    let data = document.data()

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
                        status: .Open,
                        applicationStatus: .pending,
                        isHidden: data["isHidden"] as? Bool ?? false
                    )

                    recommendations.append(jobAd)
                }

                self.jobRecommendations = recommendations
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
    

    // Prepare for the segue to NewJobDetailViewController
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


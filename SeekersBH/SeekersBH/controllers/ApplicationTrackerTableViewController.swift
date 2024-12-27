////
////  ApplicationTrackerTableViewController.swift
////  SeekersBH
////
////  Created by marwa on 27/12/2024.
////
//
//import FirebaseFirestore
//import UIKit
//
//class ApplicationTrackerTableViewController: UITableViewController {
//    
//    @IBOutlet weak var appTracker: UITableView!
//    
//    
//    
//    var jobs: [[String: Any]] = []  // This will hold all job data fetched from Firebase
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // appTracker.delegate = self // No need to set delegate, UITableViewController does it automatically
//        // appTracker.dataSource = self // No need to set dataSource, UITableViewController does it automatically
//        
//        // Register the cell class or nib
//        appTracker.register(ApplicationTrackerTableViewCell.self, forCellReuseIdentifier: "ApplicationTrackerCell")
//        
//        // Fetch jobs from Firebase
//        fetchJobsFromFirebase()
//    }
//    
//    // Fetch jobs from Firebase Firestore
//    func fetchJobsFromFirebase() {
//        let db = Firestore.firestore()
//        
//        db.collection("jobs").getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Error fetching jobs: \(error.localizedDescription)")
//            } else {
//                self.jobs = snapshot?.documents.map { document in
//                    return document.data()
//                } ?? []
//                self.appTracker.reloadData()
//            }
//        }
//    }
//    
//    // TableView DataSource methods
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return jobs.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationTrackerCell", for: indexPath) as! ApplicationTrackerTableViewCell
//        
//        let jobData = jobs[indexPath.row]
//        cell.configureCell(with: jobData)
//        
//        return cell
//    }
//}

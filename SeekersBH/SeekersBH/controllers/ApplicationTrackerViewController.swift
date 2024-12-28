//
//  ApplicationTrackerViewController.swift
//  SeekersBH
//
//  Created by marwa on 27/12/2024.
//

import FirebaseFirestore
import UIKit

class ApplicationTrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var appTracker: UITableView!
    
    var jobs: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appTracker.delegate = self
        appTracker.dataSource = self
        
        fetchJobsFromFirebase()
    }
    
    func fetchJobsFromFirebase() {
        let db = Firestore.firestore()
        
        db.collection("jobs").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching jobs: \(error.localizedDescription)")
            } else {
                self.jobs = snapshot?.documents.map { document in
                    return document.data()
                } ?? []
                self.appTracker.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationTrackerCell", for: indexPath) as! ApplicationTrackerTableViewCell
        
        let jobData = jobs[indexPath.row]
        cell.configureCell(with: jobData)
        
        return cell
    }
}

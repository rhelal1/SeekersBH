//
//  CVSelectionApplicationsTableViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 25/12/2024.
//

import UIKit
import Firebase

class CVSelectionApplicationsTableViewController: UITableViewController {

    @IBOutlet weak var dropdownButton: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var cvTableView: UITableView!
    
   //for drop down menu
    var isDropdownOpen = false // Tracks whether the dropdown menu is open or closed
        var cvNames: [String] = [] // Array to store CV names fetched from Firebase
        var selectedCV: String? // Holds the name of the selected CV
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register custom cell for main table view (if using a custom cell)
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MainCell")
        cvTableView.delegate = self
                cvTableView.dataSource = self
                cvTableView.isHidden = true // Start with the table view hidden (dropdown closed)
        fetchCVsFromFirebase() // Fetch CV names from Firebase
    }
    
    
    @IBAction func dropdownButtonTapped(_ sender: Any) {
        
        isDropdownOpen.toggle() // Switch between true and false
                cvTableView.isHidden = !isDropdownOpen // Show or hide the table view based on isDropdownOpen
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
  
       

  
    
  
    // Fetch CVs from Firebase based on the userID
       private func fetchCVsFromFirebase() {
           guard let userID = AccessManager.userID else { return } // Ensure userID is available
           let db = Firestore.firestore()
           
           db.collection("CV")
               .whereField("userID", isEqualTo: userID) // Query CVs where userID matches
               .getDocuments { [weak self] (querySnapshot, error) in
                   if let error = error {
                       print("Error fetching CVs: \(error)")
                       return
                   }
                   
                   // Extract CV names from the documents and populate the cvNames array
                   guard let documents = querySnapshot?.documents else { return }
                   self?.cvNames = documents.compactMap { $0.data()["cvName"] as? String }
                   
                   // Reload the table view with the fetched data
                   DispatchQueue.main.async {
                       self?.cvTableView.reloadData()
                   }
               }
       }

 

}

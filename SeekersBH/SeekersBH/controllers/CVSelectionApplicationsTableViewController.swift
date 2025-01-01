////
////  CVSelectionApplicationsTableViewController.swift
////  SeekersBH
////
////  Created by Duha Hashem on 25/12/2024.
////
//
//import UIKit
//import Firebase
//
//class CVSelectionApplicationsTableViewController: UITableViewController {
//    
//    @IBOutlet weak var dropdownButton: UIButton!
//    
//    @IBOutlet weak var uploadButton: UIButton!
//    
//    @IBOutlet weak var cvTableView: UITableView!
//    
//    var isDropdownOpen = false // Tracks whether the dropdown is open
//       var cvNames: [String] = [] // Array to store fetched CV names
//       var selectedCV: String? // Holds the name of the selected CV
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        cvTableView.tag = 101 // Assign a unique tag
//
//        
//    }
//    
//    
//    @IBAction func dropdownButtonTapped(_ sender: Any) {
//        isDropdownOpen.toggle()  // Toggle dropdown state
//           cvTableView.isHidden = !isDropdownOpen  // Show or hide the dropdown table
//        
//    }
//    
//    //static table view
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    
//    // Number of rows
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView.tag == 101 { // Check if it's the dropdown table
//            return cvNames.count  // Return the number of CVs
//        }
//        // For the static table, defer to the superclass implementation
//        return super.tableView(tableView, numberOfRowsInSection: section)
//    }
//
//    // Configure each cell
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView.tag == 101 { // Check if it's the dropdown table
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CVCellDropDown", for: indexPath)
//            cell.textLabel?.text = cvNames[indexPath.row]  // Set CV name
//            return cell
//        }
//        // For the static table, defer to the superclass implementation
//        return super.tableView(tableView, cellForRowAt: indexPath)
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView.tag == 101 { // Dropdown table
//            selectedCV = cvNames[indexPath.row]  // Save the selected CV
//            dropdownButton.setTitle(selectedCV, for: .normal)  // Update button text
//            cvTableView.isHidden = true  // Hide dropdown
//        } else {
//            // Handle the selection in the static table view
//            super.tableView(tableView, didSelectRowAt: indexPath)
//        }
//    }
//
//    
//   
//        
//        
//        
//        
//        
//        
//    }
//
//

//
//  CVSelectionApplicationsTableViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 25/12/2024.
//

import UIKit
import Firebase

class CVSelectionApplicationsTableViewController: UITableViewController {
    
    //@IBOutlet weak var dropdownButton: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    //@IBOutlet weak var cvTableView: UITableView!
    
    var isDropdownOpen = false // Tracks whether the dropdown is open
       var cvNames: [String] = [] // Array to store fetched CV names
       var selectedCV: String? // Holds the name of the selected CV
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        
    }
    
    
    //@IBAction func dropdownButtonTapped(_ sender: Any) {
       
        
    //}
    
    //static table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
   
   

    
   
        
        
        
        
        
        
    }



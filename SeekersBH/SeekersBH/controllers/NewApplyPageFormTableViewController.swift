//
//  NewApplyPageFormTableViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 16/12/2024.
//

import UIKit

class NewApplyPageFormTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Allow the table view to automatically adjust row height
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    
    //customize the header's color, font and size
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
            header.textLabel?.textColor = UIColor(red: 9/255, green: 24/255, blue: 86/255, alpha: 1) // Color #091856
        }
    }

}

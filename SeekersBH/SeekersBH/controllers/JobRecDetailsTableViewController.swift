//
//  JobRecDetailsTableViewController.swift
//  SeekersBH
//
//  Created by Duha Hashem on 14/12/2024.
//

import UIKit

class JobRecDetailsTableViewController: UITableViewController {
    
    
    
    let sections = ["General Information", "Job Description", "Key Responsibilities", "Requirements", "Benefits"]
    let generalInfo = ["Location: Remote", "Employment Type: Full-Time", "Experience: 3+ Years", "Salary: $80,000 - $100,000"]
    let jobDescription = ["This is a detailed job description hhegdguiwgfiF FEWGFGIF."]
    let keyResponsibilities = ["Responsibility 1", "Responsibility 2", "Responsibility 3"]
    let requirements = ["Requirement 1", "Requirement 2"]
    let benefits = ["Benefit 1", "Benefit 2", "Benefit 3"]
    
    var data: [[String]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        data = [generalInfo, jobDescription, keyResponsibilities, requirements, benefits]
        
        // Enable dynamic cell sizing
        tableView.rowHeight = UITableView.automaticDimension
        
        // Register the static cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StaticCell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StaticCell", for: indexPath)
        
        // Configure the cell content
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.textLabel?.numberOfLines = 0
        
        
        // Style the content view for rounded corners
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
       
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont(name: "Helvetica", size: 20)
            header.textLabel?.textColor = UIColor(named: "#091856")
        }
        
        
        /*
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
         
         // Configure the cell...
         
         return cell
         }
         */
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}

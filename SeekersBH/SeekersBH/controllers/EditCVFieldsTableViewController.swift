//
//  EditCVFieldsTableViewController.swift
//  SeekersBH
//
//  Created by marwa on 25/12/2024.
//

import UIKit

class EditCVFieldsTableViewController: UITableViewController {
    
    @IBOutlet weak var editFullName: UITextField!
    @IBOutlet weak var editEmail: UITextField!
    @IBOutlet weak var editPhoneNumber: UITextField!
    @IBOutlet weak var editLinkedIn: UITextField!
    @IBOutlet weak var editPortfolio: UITextField!
    @IBOutlet weak var editCvName: UITextField!
    @IBOutlet weak var editAboutMe: UITextField!
    @IBOutlet weak var editDegree: UITextField!
    @IBOutlet weak var editUniversity: UITextField!
    @IBOutlet weak var editSkills: UITextField!
    @IBOutlet weak var editOtherSkills: UITextField!
    @IBOutlet weak var editCertName: UITextField!
    @IBOutlet weak var editCertDate: UITextField!
    @IBOutlet weak var editCertOrg: UITextField!
    @IBOutlet weak var editOtherCert: UITextField!
    @IBOutlet weak var EditProjectName: UITextField!
    @IBOutlet weak var editProjectURL: UITextField!
    
    @IBOutlet weak var editProjectOverview: UITextField!
    @IBOutlet weak var editOtherProjects: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    //
    
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

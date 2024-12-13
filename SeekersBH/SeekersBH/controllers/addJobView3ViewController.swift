//
//  addJobView3ViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class addJobView3ViewController: UIViewController {
    
    
    @IBAction func finishbtn(_ sender: UIButton) {
        showAlert()
    }
    @IBOutlet weak var vieww: UIView!
    @IBOutlet weak var textview1: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        vieww.layer.cornerRadius = 10
        textview1.layer.cornerRadius = 10
    }
    func showAlert() {
        // Create the alert controller
        let alert = UIAlertController(title: "", message: "Job Application added Successfully", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Done", style: .default) { _ in
                // Ensure you’re only performing the segue once
                if !self.isSegueAlreadyPerformed {
                    self.isSegueAlreadyPerformed = true
                    self.performSegue(withIdentifier: "goToNextPage", sender: self)
                }
               
            }
        
        
        // Add the action to the alert
        alert.addAction(okAction)
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    var isSegueAlreadyPerformed = false
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  OptionViewController.swift
//  SeekersBH
//
//  Created by Ruqaya Helal on 29/12/2024.
//

import UIKit

class OptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserManagmentButton.isHidden = true
        ResourceManagemntButton.isHidden = true
        AdminJobManagmentButton.isHidden = true
        
        growthHubButton.isHidden = true
        onlineCoursesButton.isHidden = true
        
        JobManagmentButton.isHidden = true
        JobApplicationTrackerButton.isHidden = true
        CreatedCVButton.isHidden = true
        CreateCVButton.isHidden = true
        
        
        if AccessManager.Role == "Admin" {
            UserManagmentButton.isHidden = false
            ResourceManagemntButton.isHidden = false
            AdminJobManagmentButton.isHidden = false
            
            growthHubButton.isHidden = false
            onlineCoursesButton.isHidden = false

        } else if AccessManager.Role == "User" {
            JobApplicationTrackerButton.isHidden = false
            CreatedCVButton.isHidden = false
            CreateCVButton.isHidden = false
            
            growthHubButton.isHidden = false
            onlineCoursesButton.isHidden = false
        } else if AccessManager.Role == "Employer" {
            JobManagmentButton.isHidden = false
        }
    }
    
    @IBOutlet weak var growthHubButton: UIButton!
    @IBOutlet weak var onlineCoursesButton: UIButton!
    @IBOutlet weak var JobApplicationTrackerButton: UIButton!
    @IBOutlet weak var CreatedCVButton: UIButton!
    @IBOutlet weak var CreateCVButton: UIButton!

    @IBOutlet weak var UserManagmentButton: UIButton!
    @IBOutlet weak var ResourceManagemntButton: UIButton!
    @IBOutlet weak var AdminJobManagmentButton: UIButton!
    
    @IBOutlet weak var JobManagmentButton: UIButton!
    
    

    
}

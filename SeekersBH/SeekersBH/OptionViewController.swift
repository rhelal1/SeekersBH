import UIKit

class OptionViewController: UIViewController {
    
    @IBOutlet weak var growthHubButton: UIButton!
    @IBOutlet weak var onlineCoursesButton: UIButton!
    @IBOutlet weak var JobApplicationTrackerButton: UIButton!
    @IBOutlet weak var CreatedCVButton: UIButton!
    @IBOutlet weak var CreateCVButton: UIButton!
    @IBOutlet weak var UserManagmentButton: UIButton!
    @IBOutlet weak var ResourceManagemntButton: UIButton!
    @IBOutlet weak var AdminJobManagmentButton: UIButton!
    @IBOutlet weak var JobManagmentButton: UIButton!
    
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
            
        } else if AccessManager.Role == "NormalUser" {
            JobApplicationTrackerButton.isHidden = false
            CreatedCVButton.isHidden = false
            CreateCVButton.isHidden = false
            
            growthHubButton.isHidden = false
            onlineCoursesButton.isHidden = false
        } else if AccessManager.Role == "Employer" {
            JobManagmentButton.isHidden = false
        }
    }
    
    
    @IBAction func onlineCoursesTapButton(_ sender: Any) {
        navigationHelper(storybosrdName: "ruqaya", viewControllerName: "CourseViewController")
    }
    
    
    @IBAction func growthHubTapButton(_ sender: Any) {
        navigationHelper(storybosrdName: "ruqaya", viewControllerName: "GrowthHubViewController")
    }
    
    @IBAction func jobApplicationTrackerbuttonTapped(_ sender: Any) {
        navigationHelper(storybosrdName: "marwa", viewControllerName: "ApplicationTrackerViewController")
    }
    
    @IBAction func createdCVButtonTapped(_ sender: Any) {
        navigationHelper(storybosrdName: "marwa", viewControllerName: "AllCVViewController")
    }

    @IBAction func createCVTapButton(_ sender: Any) {
        navigationHelper(storybosrdName: "marwa", viewControllerName: "CreateCVViewController")
    }
    
    @IBAction func JobManagmentButtonTapped(_ sender: Any) {
        navigationHelper(storybosrdName: "qasim", viewControllerName: "JobManagemntViewController")
    }
    
    
    @IBAction func settingButtonTapped(_ sender: Any) {
        navigationHelper(storybosrdName: "reem", viewControllerName: "Settings")
    }
    
    
    func navigationHelper(storybosrdName : String, viewControllerName : String) {
        // Load the storyboard
        let storyboard = UIStoryboard(name: storybosrdName, bundle: nil)
        
        // Instantiate the viewController from the storyboard
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName)
        
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func userManagmentButtonTapped(_ sender: Any) {
        navigationHelper(storybosrdName: "zainab", viewControllerName: "ManageUsers")
    }
    
    @IBAction func resourceManagmentButtonTapped(_ sender: Any) {
        navigationHelper(storybosrdName: "zainab", viewControllerName: "ResourceManagementViewController")
    }
    
    @IBAction func adminJobManagemntButtonTapped(_ sender: Any) {
        navigationHelper(storybosrdName: "zainab", viewControllerName: "ManageJobsViewController")
    }
}

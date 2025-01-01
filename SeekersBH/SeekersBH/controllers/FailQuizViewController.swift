import UIKit

class FailQuizViewController: UIViewController {
    
    var score : Int = 0
    var returnTo : UIViewController!
    var course : Course!

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func ReTakeTheQuizButtonTapped(_ sender: Any) {
        // Instantiate the CourseQuizViewController
        if let courseQuizVC = storyboard?.instantiateViewController(withIdentifier: "CourseQuizViewController") as? CourseQuizViewController {
            
            // Pass the selected course to the CourseQuizViewController
            courseQuizVC.course = course

            courseQuizVC.modalPresentationStyle = .fullScreen
            present(courseQuizVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func ReturnButtonTapped(_ sender: Any) {
        // Load the root view controller from the "Main" storyboard
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "mainStoryboard")

        // Create a UINavigationController with the root view controller from the "Main" storyboard
        let navController = UINavigationController(rootViewController: rootViewController)

        // Load the CourseViewController from the current storyboard
        if let courseViewController = storyboard?.instantiateViewController(withIdentifier: "CourseViewController") as? CourseViewController {
            // Push the CourseViewController onto the navigation stack
            navController.pushViewController(courseViewController, animated: false)
        }

        // Set the presentation style to full screen
        navController.modalPresentationStyle = .fullScreen

        // Present the navigation controller
        present(navController, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the default back button
        self.navigationItem.hidesBackButton = true
        
        scoreLabel.text = "Your score is \(score)%."
    }

}

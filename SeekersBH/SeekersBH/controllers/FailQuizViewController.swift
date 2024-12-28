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
        let courseViewController = storyboard?.instantiateViewController(withIdentifier: "CourseViewController") as! CourseViewController
        let navController = UINavigationController(rootViewController: courseViewController)
        present(navController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the default back button
        self.navigationItem.hidesBackButton = true
        
        scoreLabel.text = "Your score is \(score)%."
    }

}

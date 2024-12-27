import UIKit

class FailQuizViewController: UIViewController {
    
    var score : Int = 0
    var returnTo : UIViewController!
    var course : Course!

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func ReTakeTheQuizButtonTapped(_ sender: Any) {
        // Dismiss the view controller and inform the quiz controller to reset answers
        if let presentingVC = presentingViewController as? CourseQuizViewController {
            presentingVC.resetQuiz()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ReturnButtonTapped(_ sender: Any) {
        // Instantiate the CourseDetailsViewController
        if let courseDetailsVC = storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as? CourseDetailsViewController {
            // Pass the course to the CourseDetailsViewController
            courseDetailsVC.course = course

//            // Push the detail view controller
//            navigationController?.pushViewController(courseDetailsVC, animated: true)
            
            courseDetailsVC.modalPresentationStyle = .fullScreen


            present(courseDetailsVC, animated: true, completion: nil)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Your score is \(score)%."
    }

}

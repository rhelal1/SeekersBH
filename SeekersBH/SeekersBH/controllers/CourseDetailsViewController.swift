import UIKit

class CourseDetailsViewController: UIViewController {
    
    var course : Course!
    
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var descrView: UIView!
    
    @IBOutlet weak var courseTitle: UILabel!
    
    @IBOutlet weak var instructor: UILabel!
    @IBOutlet weak var modules: UILabel!
    @IBOutlet weak var prerequisites: UILabel!
    @IBOutlet weak var outcomes: UILabel!
    
    @IBOutlet weak var courseDescription: UILabel!
    
    
    @IBAction func exploreNow(_ sender: Any) {
        // Instantiate the CourseContentViewController
        if let courseContentVC = storyboard?.instantiateViewController(withIdentifier: "CourseContentViewController") as? CourseContentViewController {
            // Pass the selected course to the CourseContentViewController
            courseContentVC.courseContents = course.courseContent

            // Push the detail view controller
            navigationController?.pushViewController(courseContentVC, animated: true)
        }
    }
    
    @IBAction func seeComments(_ sender: Any) {
        // Instantiate the CourseContentViewController
        if let courseReviewVC = storyboard?.instantiateViewController(withIdentifier: "CourseReviewViewController") as? CourseReviewViewController {
            // Pass the selected course to the CourseContentViewController
            courseReviewVC.courseComments = course.courseComments
            courseReviewVC.ratingText = "\(course.rating)/5 (\(course.courseComments.count) reviews)"
            // Push the detail view controller
            navigationController?.pushViewController(courseReviewVC, animated: true)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generalView.layer.cornerRadius = 15
        generalView.layer.masksToBounds = true
        
        descrView.layer.cornerRadius = 15
        descrView.layer.masksToBounds = true
        
        imageV.layer.cornerRadius = 15
        
        courseTitle.text = course.title
        instructor.text = course.instructor
        prerequisites.text = course.prerequisites
        outcomes.text = course.outcomes

        modules.text = "\(course.courseContent.count)"
        
        imageV.image = UIImage(named: "imageTest2")
        
        courseDescription.text = course.description
    }

}

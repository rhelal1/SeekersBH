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
            courseContentVC.course = course
            
            // Push the detail view controller
            navigationController?.pushViewController(courseContentVC, animated: true)
        }
    }
    
    @IBAction func seeComments(_ sender: Any) {
        // Instantiate the CourseContentViewController
        if let courseReviewVC = storyboard?.instantiateViewController(withIdentifier: "CourseReviewViewController") as? CourseReviewViewController {
            // Pass the selected course to the CourseContentViewController
            courseReviewVC.courseComments = course.courseComments
            courseReviewVC.ratingText = "\(calculateAverageRating(comments: course.courseComments))/5 (\(course.courseComments.count) reviews)"
            // Push the detail view controller
            navigationController?.pushViewController(courseReviewVC, animated: true)
        }
    }
    
    func calculateAverageRating(comments: [CourseComments]) -> Double {
        guard !comments.isEmpty else { return 0.0 } // Return 0 if the array is empty

        var totalRating = 0
        var ratingCount = 0

        // Loop over the comments to calculate the total rating and count
        for comment in comments {
            totalRating += comment.rated
            ratingCount += 1
        }

        // Calculate the average rating
        let averageRating = Double(totalRating) / Double(ratingCount)
        return averageRating
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
        
        // Load the image asynchronously
            if let imageUrl = URL(string: course.pictureUrl) {
                // Perform the network request asynchronously
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let error = error {
                        print("Error loading image: \(error.localizedDescription)")
                        return
                    }
                    
                    // Ensure data is available and it is valid
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            // Update the image view on the main thread
                            self.imageV.image = image
                        }
                    }
                }.resume()
            }
        courseDescription.text = course.description
    }

}

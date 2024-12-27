import UIKit

class PassQuizViewController: UIViewController {

    var score : Int = 0
    var course : Course!
    var cvNames : [String] = []
    // Array to hold the buttons
    var starButtons: [UIButton] = []
    
    // Store the rating value
    var currentRating: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var CVList: UIButton!
    @IBOutlet weak var viewReview: UIView!
    @IBOutlet weak var commentBox: UITextField!
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBAction func RetunbuttonTapped(_ sender: Any) {
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
    
    @IBAction func AddCVButtonTapped(_ sender: Any) {
 
    }
    
    // Function to update the star buttons based on the rating
        func updateStars(rating: Int) {
            for (index, button) in starButtons.enumerated() {
                let imageName = index < rating ? "star.fill" : "star"
                button.setImage(UIImage(systemName: imageName), for: .normal)
            }
        }
        
        // Handle star button taps
        @IBAction func starTapped(_ sender: UIButton) {
            // Update the rating based on the button's tag
            currentRating = sender.tag
            print(currentRating)
            updateStars(rating: currentRating)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Your score is \(score)%."
        
        // Add buttons to the array
        starButtons = [button1, button2, button3, button4, button5]
                
        // Set up the initial star state (all empty stars)
        updateStars(rating: 0)
        
        let certification = CourseCertification(
            title: "Python Basics Certification",
            courseId: course.id,              // ID of the course
            date: Date(),                       // Current date
            userId: AccessManager.userID!,
            score: score
        )

        CourseManager.share.addCourseCertification(certification: certification) { result in
            switch result {
            case .success:
                print("Certification added successfully!")
            case .failure(let error):
                print("Failed to add certification: \(error.localizedDescription)")
            }
        }
        
        Task {
            do {
                cvNames = try await CourseManager.share.fetchTheUserCVs(forUserID: AccessManager.userID!)
                
                // Create UIAction for each CVName
                       let actions = cvNames.map { cvName in
                           UIAction(title: cvName) { _ in
                               // Update the button's title when an option is selected
                               self.CVList.setTitle(cvName, for: .normal)
                           }
                       }
                       
                       // Create the menu with the actions
                       let menu = UIMenu(children: actions)
                       
                       // Assign the menu to the button
                       CVList.menu = menu
                       CVList.showsMenuAsPrimaryAction = true // Automatically show the menu when tapped
                
            } catch {
                print("Error fetching CV names: \(error.localizedDescription)")
            }
        }
    }
    
}

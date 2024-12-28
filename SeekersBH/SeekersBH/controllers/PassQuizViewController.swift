import UIKit

class PassQuizViewController: UIViewController {

    var score : Int = 0
    var course : Course!
    var cvNames : [String] = []
    // Array to hold the buttons
    var starButtons: [UIButton] = []
    
    // Store the rating value
    var currentRating: Int = 0
    @IBOutlet weak var commentBox: UITextField!
    
    // Variable to store the selected CV
    var selectedCV: CVInfo?

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var CVList: UIButton!
    @IBOutlet weak var viewReview: UIView!
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBAction func RetunbuttonTapped(_ sender: Any) {
        returnToCourses()
    }
    
    // Function that will be called when a user selects a CV from the menu
    func handleSelectedCV(cv: CVInfo) {
        // Store the selected CV
        self.selectedCV = cv
        // Update the button's title to the selected CV's name
        CVList.setTitle(cv.name, for: .normal)
    }
    
    @IBAction func AddCVButtonTapped(_ sender: Any) {
        guard let selectedCV = selectedCV else {
               // Show alert if no CV is selected
               showAlert(title: "Error", message: "No CV selected")
               return
           }

           // Get the selected CV ID
           let cvID = selectedCV.id
           
           // Prepare the new certification data (replace these with real data)
           let newCertification = [
            "certificationName": course.title, // Certification name
               "certificationDateObtained": DateFormatter().string(from: Date())
, // Date the certification was obtained
               "certificationIssuingOrganization": "SeekersBH" // Issuing organization
           ]
           
           // Add the new certification to the selected CV
           Task {
               do {
                   // Fetch the current certifications of the selected CV
                   var certifications = try await CourseManager.share.fetchCertifications(forCVID: cvID)
                   
                   // Add the new certification to the certifications array
                   certifications.append(newCertification)
                   
                   // Update the certifications in Firestore
                   CourseManager.share.updateCertifications(forCVID: cvID, certifications: certifications) { error in
                       if let error = error {
                           // Show alert if there's an error during the update
                           self.showAlert(title: "Error", message: "Failed to add certification: \(error.localizedDescription)")
                       } else {
                           // Show success alert
                           self.showAlert(title: "Success", message: "Certification added successfully!")
                       }
                   }
               } catch {
                   // Show alert if there's an error fetching certifications
                   self.showAlert(title: "Error", message: "Failed to fetch certifications: \(error.localizedDescription)")
               }
           }
    }
    
    func returnToCourses(){
        let courseViewController = storyboard?.instantiateViewController(withIdentifier: "CourseViewController") as! CourseViewController
        let navController = UINavigationController(rootViewController: courseViewController)
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func addReviewButtonTapped(_ sender: Any) {
        // Validate the rating
           guard currentRating > 0 else {
               showAlert(title: "Invalid Rating", message: "You must rate the course before adding a comment.")
               return
           }

        // Validate the comment text
        guard let commentText = commentBox.text, commentText.count >= 3 else {
            showAlert(title: "Invalid Comment", message: "Comment must be at least 3 characters long.")
            return
        }

        
        submitComment()
        
    }
    

    // Call this function and handle the alert
    func submitComment() {
        let courseId = course.id
        let userId = AccessManager.userID!
        let commentText = commentBox.text!
        let rating = currentRating

        CourseManager.share.addComment(courseId: courseId, commentText: commentText, userId: userId, rated: rating) { error in
            if let error = error {
                self.showAlert(title: "Error", message: "Failed to add comment: \(error.localizedDescription)")
            } else {
                self.showAlertWithCompletion(title: "Success", message: "Comment added successfully!"){
                    self.returnToCourses()

                }
            }
        }
    }
    
    // Show an alert with a completion handler
    func showAlertWithCompletion(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion() // Call the completion handler when "OK" is tapped
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    // Alert function
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
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
        
        // Hide the default back button
        self.navigationItem.hidesBackButton = true
        
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
                let userCVs = try await CourseManager.share.fetchTheUserCVs(forUserID: AccessManager.userID!)
                if userCVs.count > 0 {
                    // Create UIAction for each CVInfo
                    let actions = userCVs.map { cv in
                        UIAction(title: cv.name) { _ in
                            // Update the button's title when an option is selected
                            self.CVList.setTitle(cv.name, for: .normal)
                            self.selectedCV = cv
                        }
                    }
                    
                    // Create the menu with the actions
                    let menu = UIMenu(children: actions)
                    
                    // Assign the menu to the button
                    CVList.menu = menu
                    CVList.showsMenuAsPrimaryAction = true // Automatically show the menu when tapped
                
                    } else {
                        // Handle the case where cvNames is empty
                        self.CVList.setTitle("No CVs available", for: .normal)
                        self.CVList.menu = nil // Clear the menu if there are no CVs
                        // Optionally, you might want to show an alert or a message to the user
                    }
            } catch {
                print("Error fetching CV names: \(error.localizedDescription)")
            }
        }
    }
    
}

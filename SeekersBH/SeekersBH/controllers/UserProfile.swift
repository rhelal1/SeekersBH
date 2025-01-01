import UIKit
import FirebaseFirestore

class UserProfile: UIViewController {

    @IBOutlet weak var skills: UILabel!  // Label to display skills
    @IBOutlet weak var interest: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var DateOfBirth: UILabel!
    @IBOutlet weak var followingNum: UILabel!
    @IBOutlet weak var followersNum: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var firstNameAndLastName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfileData()
        loadUserSkills()  // Add this line to load skills when the page loads
    }
    
    private func loadUserProfileData() {
        let db = Firestore.firestore()
        
        // Fetch user data using the logged-in user's ID
        db.collection("User")
            .whereField("userID", isEqualTo: User.loggedInID)
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error getting user data: \(error.localizedDescription)")
                    self.showAlert(message: "Could not fetch user profile data.")
                    return
                }
                
                guard let document = querySnapshot?.documents.first else {
                    self.showAlert(message: "User document not found.")
                    return
                }
                
                // Extract user data from the document
                let firstName = document.get("firstName") as? String ?? "Unknown"
                let lastName = document.get("lastName") as? String ?? "Unknown"
                let email = document.get("email") as? String ?? "No email"
                let followers = document.get("followers") as? Int ?? 0
                let following = document.get("following") as? Int ?? 0
                let company = document.get("recentCompany") as? String ?? "No company"
                let jobTitle = document.get("recentJob") as? String ?? "No job title"
                let location = document.get("location") as? String ?? "Unknown"
                
                // Extract Date of Birth and format it to a readable string
                if let timestamp = document.get("dateOfBirth") as? Timestamp {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .medium
                    dateFormatter.timeStyle = .none
                    let formattedDate = dateFormatter.string(from: timestamp.dateValue())
                    self.DateOfBirth.text = formattedDate
                } else {
                    self.DateOfBirth.text = "No date of birth"
                }
                
                // Load and display interests
                self.loadUserInterests()

                // Update UI with the user's data
                DispatchQueue.main.async {
                    self.firstNameAndLastName.text = "\(firstName) \(lastName)"
                    self.email.text = email
                    self.followersNum.text = "\(followers)"
                    self.followingNum.text = "\(following)"
                    self.company.text = company
                    self.jobTitle.text = jobTitle
                    self.location.text = location
                }
            }
    }
    
    private func loadUserSkills() {
        let db = Firestore.firestore()
        
        // Fetch user skills from the database
        db.collection("Skill")
            .whereField("userID", isEqualTo: User.loggedInID)
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error getting skills data: \(error.localizedDescription)")
                    self.showAlert(message: "Could not fetch user skills.")
                    return
                }
                
                guard let document = querySnapshot?.documents.first else {
                    self.showAlert(message: "User skills document not found.")
                    return
                }
                
                // Extract skills from the document
                let skill1 = document.get("skill1") as? String ?? "No skill"
                let skill2 = document.get("skill2") as? String ?? "No skill"
                let skill3 = document.get("skill3") as? String ?? "No skill"
                let skill4 = document.get("skill4") as? String ?? "No skill"
                
                // Filter out "No skill" and join the remaining skills with a newline
                let skills = [skill1, skill2, skill3, skill4].filter { $0 != "No skill" }
                
                // Join remaining valid skills with a newline
                let allSkills = skills.joined(separator: "\n")
                
                // Print a message when skills are successfully fetched
                print("User skills loaded: \(allSkills)")
                
                // Update UI with the user's skills
                DispatchQueue.main.async {
                    self.skills.text = allSkills
                }
            }
    }
    
    private func loadUserInterests() {
        let db = Firestore.firestore()
        
        // Fetch user interests
        db.collection("Interest")
            .whereField("userID", isEqualTo: User.loggedInID)
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error getting interests data: \(error.localizedDescription)")
                    self.showAlert(message: "Could not fetch user interests.")
                    return
                }
                
                guard let document = querySnapshot?.documents.first else {
                    self.showAlert(message: "User interests document not found.")
                    return
                }
                
                // Extract interests from the document
                let interest1 = document.get("interest1") as? String ?? "No interest"
                let interest2 = document.get("interest2") as? String ?? "No interest"
                let interest3 = document.get("interest3") as? String ?? "No interest"
                let interest4 = document.get("interest4") as? String ?? "No interest"
                
                // Filter out "No interest" and make sure the interests don't contain unwanted line breaks
                let interests = [interest1, interest2, interest3, interest4]
                    .filter { $0 != "No interest" }
                    .map { $0.replacingOccurrences(of: "\n", with: " ") } // Remove unwanted newlines inside each interest
                
                // Join remaining valid interests with a newline
                let allInterests = interests.joined(separator: "\n")
                
                // Print a message when interests are successfully fetched
                print("User interests loaded: \(allInterests)")
                
                // Update UI with the user's interests
                DispatchQueue.main.async {
                    self.interest.text = allInterests
                }
            }
    }
    
    // Helper method to show an alert
    private func showAlert(message: String, title: String = "Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

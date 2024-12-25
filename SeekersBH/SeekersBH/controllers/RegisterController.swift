import UIKit
import FirebaseFirestore

class RegisterController: UIViewController {

    @IBOutlet weak var confirmPasstxt: UITextField!
    @IBOutlet weak var passtxt: UITextField!
    @IBOutlet weak var recentCompanytxt: UITextField!
    @IBOutlet weak var recentJobtxt: UITextField!
    @IBOutlet weak var locationtxt: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var contnuebtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Attach the validation function to the "Continue" button
        contnuebtn.addTarget(self, action: #selector(validateInputs), for: .touchUpInside)
    }
    
    @objc func validateInputs() {
        // Validate email format
        guard let email = emailtxt.text, !email.isEmpty, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address.")
            return
        }
        
        // Validate required fields
        guard let firstName = fName.text, !firstName.isEmpty else {
            showAlert(message: "First name is required.")
            return
        }
        guard let lastName = lName.text, !lastName.isEmpty else {
            showAlert(message: "Last name is required.")
            return
        }
        guard let username = userName.text, !username.isEmpty else {
            showAlert(message: "Username is required.")
            return
        }
        guard let location = locationtxt.text, !location.isEmpty else {
            showAlert(message: "Location is required.")
            return
        }
        guard let recentJob = recentJobtxt.text, !recentJob.isEmpty else {
            showAlert(message: "Recent job is required.")
            return
        }
        guard let recentCompany = recentCompanytxt.text, !recentCompany.isEmpty else {
            showAlert(message: "Recent company is required.")
            return
        }

        // Validate password fields
        guard let password = passtxt.text, !password.isEmpty else {
            showAlert(message: "Password is required.")
            return
        }
        guard password.count >= 8 else {
            showAlert(message: "Password must be at least 8 characters long.")
            return
        }
        guard let confirmPassword = confirmPasstxt.text, confirmPassword == password else {
            showAlert(message: "Passwords do not match.")
            return
        }
        
        // Check if the user already exists in Firestore
        checkIfUserExists(email: email) { exists in
            if exists {
                self.showAlert(message: "An account with this email already exists.", title: "Error")
            } else {
                // Proceed to save data in Firestore if user does not exist
                self.saveUserData(firstName: firstName, lastName: lastName, username: username, email: email, location: location, recentJob: recentJob, recentCompany: recentCompany, password: password)
            }
        }
    }
    
    func checkIfUserExists(email: String, completion: @escaping (Bool) -> Void) {
        // Reference to Firestore
        let db = Firestore.firestore()
        
        // Check if the email already exists in the Firestore collection "User"
        db.collection("User").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error checking user: \(error.localizedDescription)")
                completion(false) // Assume user doesn't exist on error
            } else {
                // If documents exist, the user already exists
                if let snapshot = querySnapshot, snapshot.documents.count > 0 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func saveUserData(firstName: String, lastName: String, username: String, email: String, location: String, recentJob: String, recentCompany: String, password: String) {
            // Reference to Firestore
            let db = Firestore.firestore()
            
            // Prepare the user data dictionary
            let userData: [String: Any] = [
                "firstName": firstName,
                "lastName": lastName,
                "username": username,
                "email": email,
                "location": location,
                "recentJob": recentJob,
                "recentCompany": recentCompany,
                "password": password,
                "role": "NormalUser",
                "dateOfBirth": Timestamp(date: self.date.date)
            ]
            
            // Save the user data in Firestore under "users" collection
            db.collection("User").addDocument(data: userData) { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    self.showAlert(message: "Error saving user data: \(error.localizedDescription)")
                } else {
                    // Show success alert and then navigate
                    User.loggedInUser = email
                    User.loggedInUsername = username
                    let alert = UIAlertController(title: "Success", message: "User successfully registered and saved to Firestore.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        // Navigate to InterestViewController after alert is dismissed
                        if let interestVC = self.storyboard?.instantiateViewController(withIdentifier: "InterestViewController") as? UIViewController {
                          
                            // Push the view controller
                            self.navigationController?.pushViewController(interestVC, animated: true)
                        }
                    })
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }

    func showAlert(message: String, title: String = "Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

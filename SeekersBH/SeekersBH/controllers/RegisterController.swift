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
        checkIfUserExists(email: email, username: username) { [weak self] isEmailTaken, isUsernameTaken in
            guard let self = self else { return }
            
            if isEmailTaken {
                self.showAlert(message: "An account with this email already exists.")
            } else if isUsernameTaken {
                self.showAlert(message: "This username is already taken. Please choose another one.")
            } else {
                self.saveUserData(
                    firstName: firstName,
                    lastName: lastName,
                    username: username,
                    email: email,
                    location: location,
                    recentJob: recentJob,
                    recentCompany: recentCompany,
                    password: password
                )
            }
        }
    }
    
    func checkIfUserExists(email: String, username: String, completion: @escaping (Bool, Bool) -> Void) {
        let db = Firestore.firestore()
        
        // Create a dispatch group to handle both checks
        let group = DispatchGroup()
        var isEmailTaken = false
        var isUsernameTaken = false
        
        // Check email
        group.enter()
        db.collection("User")
            .whereField("email", isEqualTo: email)
            .getDocuments { (querySnapshot, error) in
                if let snapshot = querySnapshot, !snapshot.documents.isEmpty {
                    isEmailTaken = true
                }
                group.leave()
            }
        
        // Check username
        group.enter()
        db.collection("User")
            .whereField("username", isEqualTo: username)
            .getDocuments { (querySnapshot, error) in
                if let snapshot = querySnapshot, !snapshot.documents.isEmpty {
                    isUsernameTaken = true
                }
                group.leave()
            }
        
        // When both checks are complete
        group.notify(queue: .main) {
            completion(isEmailTaken, isUsernameTaken)
        }
    }
    
    func saveUserData(firstName: String, lastName: String, username: String, email: String, location: String, recentJob: String, recentCompany: String, password: String) {
        let db = Firestore.firestore()
        
        // Generate a new document reference to get its ID
        let newDocRef = db.collection("User").document()
        let userID = newDocRef.documentID
        
        // Prepare the user data dictionary with the userID
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
            "dateOfBirth": Timestamp(date: self.date.date),
            "userID": userID,
            "isHidden": false
        ]
        
        // Save the user data using the generated document reference
        newDocRef.setData(userData) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(message: "Error saving user data: \(error.localizedDescription)")
            } else {
                // Save the logged in user information
                User.loggedInUser = email
                User.loggedInUsername = username
                User.loggedInID = userID  // Updated to use consistent property name
                
                let alert = UIAlertController(title: "Success", message: "User successfully registered and saved to Firestore.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    if let interestVC = self.storyboard?.instantiateViewController(withIdentifier: "InterestChoice") as? UIViewController {
                        print("Successfully instantiated InterestChoice view controller")
                        
                        if let navController = self.navigationController {
                            print("Navigation controller found")
                            navController.pushViewController(interestVC, animated: true)
                        } else {
                            print("No navigation controller found")
                            self.present(interestVC, animated: true, completion: nil)
                        }
                    } else {
                        print("Failed to instantiate InterestChoice view controller")
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

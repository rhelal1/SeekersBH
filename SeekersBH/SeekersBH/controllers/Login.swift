import UIKit
import FirebaseFirestore

class Login: UIViewController {

    @IBOutlet weak var passwordTxtBx: UITextField!
    @IBOutlet weak var usernameTxtBx: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func LoginMessage(_ sender: Any) {
        // Validate username and password fields
        guard let username = usernameTxtBx.text, !username.isEmpty else {
            showAlert(title: "Error", message: "Username cannot be empty.")
            return
        }
        
        guard let password = passwordTxtBx.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Password cannot be empty.")
            return
        }
        
        // Check if the user exists in Firestore
        checkIfUserExists(username: username, password: password) { userExists, isPasswordCorrect in
            if userExists {
                if isPasswordCorrect {
                    User.loggedInUser = username
                    self.showAlert(title: "Success", message: "You logged in successfully!")
                } else {
                    self.showAlert(title: "Error", message: "Incorrect password.")
                }
            } else {
                self.showAlert(title: "Error", message: "User does not exist.")
            }
        }
    }
    
    func checkIfUserExists(username: String, password: String, completion: @escaping (Bool, Bool) -> Void) {
        // Reference to Firestore
        let db = Firestore.firestore()
        
        // Query Firestore to check if the username exists
        db.collection("User").whereField("username", isEqualTo: username).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error checking user: \(error.localizedDescription)")
                completion(false, false)
                return
            }
            
            if let snapshot = querySnapshot, snapshot.documents.count > 0 {
                // User exists, check if the password matches (note: in production, passwords should be hashed)
                if let document = snapshot.documents.first, let storedPassword = document.data()["password"] as? String {
                    if storedPassword == password {
                        
                        completion(true, true)
                    } else {
                        completion(true, false)
                    }
                } else {
                    completion(false, false)
                }
            } else {
                // No user found
                completion(false, false)
            }
        }
    }
    
    // Helper function to show alerts
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

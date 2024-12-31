import UIKit
import FirebaseFirestore

class Login: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LoginMessage(_ sender: Any) {
        // Validate username and password fields
        guard let username = usernameTextField.text, !username.isEmpty else {
            showAlert(title: "Error", message: "Username cannot be empty.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Password cannot be empty.")
            return
        }
        
        // Check if the user exists in Firestore
        checkIfUserExists(username: username, password: password) { success, userID in
            if success, let userID = userID {
                
                DispatchQueue.main.async {
                    // Show success alert and navigate
                    self.showAlert(title: "Success", message: "You logged in successfully!") {
                        // Instantiate the Main storyboard
                        // Store both username and userID
                        AccessManager.userID = userID
                        AccessManager.Role = "NormalUser"
                      
                                            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                            
                                            // Instantiate the initial view controller of the Main storyboard
                                            if let mainVC = mainStoryboard.instantiateInitialViewController() {
                                                mainVC.modalPresentationStyle = .fullScreen
                                                // Present the main view controller
                                                self.present(mainVC, animated: true, completion: nil)
                                            }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Invalid username or password.")
                }
            }
        }
    }
    
    func checkIfUserExists(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let db = Firestore.firestore()
        
        // Query Firestore to check if the username exists
        db.collection("User").whereField("username", isEqualTo: username).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error checking user: \(error.localizedDescription)")
                completion(false, nil)
                return
            }
            
            if let snapshot = querySnapshot, let document = snapshot.documents.first,
               let storedPassword = document.data()["password"] as? String {
                // Check if password matches
                if storedPassword == password {
                    // Return success with the document ID as userID
                    completion(true, document.documentID)
                } else {
                    completion(false, nil)
                }
            } else {
                completion(false, nil)
            }
        }
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        self.present(alert, animated: true, completion: nil)
    }
}

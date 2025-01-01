import UIKit
import FirebaseFirestore

class EditProfileTableViewController: UITableViewController {
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var usernametxt: UITextField!
    @IBOutlet weak var lastnametxt: UITextField!
    @IBOutlet weak var firstnametxt: UITextField!
    @IBOutlet weak var dateofbirth: UIDatePicker!
    @IBOutlet weak var locationtxt: UITextField!
    @IBOutlet weak var mostRecentJobtxt: UITextField!
    @IBOutlet weak var mostRecentCompanytxt: UITextField!
    
    private var originalUsername: String = ""
    private var originalEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
        setupSaveButton()
    }
    
    private func setupSaveButton() {
        savebtn.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func loadUserData() {
        let db = Firestore.firestore()
        print(User.loggedInID)
        db.collection("User")
            .whereField("userID", isEqualTo: AccessManager.userID!)
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error getting documents: \(error)")
                    self.showAlert(title: "Error", message: "Could not load user data")
                    return
                }
                
                guard let document = querySnapshot?.documents.first else {
                    self.showAlert(title: "Error", message: "User document not found")
                    return
                }
                
                // Store original values for validation
                self.originalUsername = document.get("username") as? String ?? ""
                self.originalEmail = document.get("email") as? String ?? ""
                
                // Update UI on main thread
                DispatchQueue.main.async {
                    self.usernametxt.text = document.get("username") as? String
                    self.firstnametxt.text = document.get("firstName") as? String
                    self.lastnametxt.text = document.get("lastName") as? String
                    self.locationtxt.text = document.get("location") as? String
                    self.mostRecentJobtxt.text = document.get("recentJob") as? String
                    self.mostRecentCompanytxt.text = document.get("recentCompany") as? String
                    
                    if let timestamp = document.get("dateOfBirth") as? Timestamp {
                        self.dateofbirth.date = timestamp.dateValue()
                    }
                }
            }
    }
    @objc private func saveButtonTapped() {
        // Validate all fields are filled
        guard let username = usernametxt.text, !username.isEmpty,
              let firstName = firstnametxt.text, !firstName.isEmpty,
              let lastName = lastnametxt.text, !lastName.isEmpty,
              let location = locationtxt.text, !location.isEmpty,
              let recentJob = mostRecentJobtxt.text, !recentJob.isEmpty,
              let recentCompany = mostRecentCompanytxt.text, !recentCompany.isEmpty else {
            showAlert(title: "Error", message: "All fields are required")
            return
        }
        
        // Check if username changed
        if username != originalUsername {
            checkUsernameAvailability(username) { [weak self] isAvailable in
                guard let self = self else { return }
                if isAvailable {
                    self.updateUserData()
                } else {
                    self.showAlert(title: "Error", message: "Username is already taken")
                }
            }
        } else {
            updateUserData()
        }
    }
    
    private func checkUsernameAvailability(_ username: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("User")
            .whereField("username", isEqualTo: username)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error checking username: \(error)")
                    completion(false)
                    return
                }
                
                if let documents = querySnapshot?.documents {
                    let isAvailable = documents.isEmpty ||
                        (documents.count == 1 && documents[0].get("username") as? String == self.originalUsername)
                    completion(isAvailable)
                } else {
                    completion(true)
                }
            }
    }
    
    private func updateUserData() {
        let db = Firestore.firestore()
        
        // First, get the document ID using the username
        db.collection("User")
            .whereField("username", isEqualTo: originalUsername)
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self,
                      let document = querySnapshot?.documents.first else { return }
                
                let userData: [String: Any] = [
                    "username": self.usernametxt.text!,
                    "firstName": self.firstnametxt.text!,
                    "lastName": self.lastnametxt.text!,
                    "location": self.locationtxt.text!,
                    "recentJob": self.mostRecentJobtxt.text!,
                    "recentCompany": self.mostRecentCompanytxt.text!,
                    "dateOfBirth": Timestamp(date: self.dateofbirth.date)
                ]
                
                // Update the document using its ID
                db.collection("User").document(document.documentID).updateData(userData) { [weak self] error in
                    if let error = error {
                        self?.showAlert(title: "Error", message: error.localizedDescription)
                    } else {
                        // Update User.loggedInUser if username changed
                        if self?.usernametxt.text != self?.originalUsername {
                            User.loggedInUser = self?.usernametxt.text ?? ""
                        }
                        
                        self?.showAlert(title: "Success", message: "Profile updated successfully") {
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    // Table view methods for static cells
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

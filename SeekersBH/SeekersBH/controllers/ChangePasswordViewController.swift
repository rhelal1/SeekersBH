import UIKit
import Firebase
import FirebaseFirestore

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var confirmPasswordtxt: UITextField!
    @IBOutlet weak var newPasswordtxt: UITextField!
    @IBOutlet weak var currentPasswordtxt: UITextField!
    @IBOutlet weak var savebtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        currentPasswordtxt.isSecureTextEntry = true
        newPasswordtxt.isSecureTextEntry = true
        confirmPasswordtxt.isSecureTextEntry = true
        
        savebtn.layer.cornerRadius = 20
        savebtn.backgroundColor = .systemBlue
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let currentPassword = currentPasswordtxt.text, !currentPassword.isEmpty,
              let newPassword = newPasswordtxt.text, !newPassword.isEmpty,
              let confirmPassword = confirmPasswordtxt.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please fill in all fields")
            return
        }
        
        // Check if passwords match
        guard newPassword == confirmPassword else {
            showAlert(message: "New password and confirmation do not match")
            return
        }
        
        // First verify current password
        let db = Firestore.firestore()
        db.collection("User").whereField("email", isEqualTo: User.loggedInUser)
            .getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    self?.showAlert(message: "Error: \(error.localizedDescription)")
                    return
                }
                
                guard let document = querySnapshot?.documents.first else {
                    self?.showAlert(message: "User document not found")
                    return
                }
                
                // Get stored password and verify
                guard let storedPassword = document.data()["password"] as? String,
                      storedPassword == currentPassword else {
                    self?.showAlert(message: "Current password is incorrect")
                    return
                }
                
                // If current password is correct, update to new password
                document.reference.updateData([
                    "password": newPassword
                ]) { error in
                    if let error = error {
                        self?.showAlert(message: "Error updating password: \(error.localizedDescription)")
                    } else {
                        self?.showAlert(message: "Password updated successfully", title: "Success") {
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
    }
    
    private func showAlert(message: String, title: String = "Error", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyCurrentTheme()
    }
}

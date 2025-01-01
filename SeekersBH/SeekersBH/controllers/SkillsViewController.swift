import UIKit
import Firebase
import FirebaseFirestore

class SkillsViewController: UIViewController {
    
    @IBOutlet weak var communication: UIButton!
    @IBOutlet weak var projectManagement: UIButton!
    @IBOutlet weak var problemSolving: UIButton!
    @IBOutlet weak var TeamworkandCollaboration: UIButton!
    @IBOutlet weak var dataAnalysis: UIButton!
    @IBOutlet weak var leadership: UIButton!
    @IBOutlet weak var timeManagement: UIButton!
    @IBOutlet weak var technicalProficiency: UIButton!
    @IBOutlet weak var customerService: UIButton!
    @IBOutlet weak var adaptability: UIButton!
    @IBOutlet weak var marketingAndSocialMedia: UIButton!
    @IBOutlet weak var negotiation: UIButton!
    @IBOutlet weak var registerButton: UIButton! // Add this outlet
    
    private var selectedSkills: [String] = []
    private let maxSelections = 4
    var isEditMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        updateRegisterButtonState()
        
        // Check if user already has skills
        checkExistingSkills()
    }
    
    private func setupButtons() {
        let allButtons: [UIButton] = [
            communication,
            projectManagement,
            problemSolving,
            TeamworkandCollaboration,
            dataAnalysis,
            leadership,
            timeManagement,
            technicalProficiency,
            customerService,
            adaptability,
            marketingAndSocialMedia,
            negotiation
        ]
        
        allButtons.forEach { button in
            button.layer.cornerRadius = 12
            button.backgroundColor = .systemGray5
            button.addTarget(self, action: #selector(skillButtonTapped(_:)), for: .touchUpInside)
        }
        
        registerButton.layer.cornerRadius = 20
        registerButton.backgroundColor = .systemGray3
    }
    
    private func checkExistingSkills() {
        let db = Firestore.firestore()
        db.collection("Skill").whereField("userID", isEqualTo: AccessManager.userID!).getDocuments { [weak self] (querySnapshot, error) in
            if let _ = querySnapshot?.documents.first {
                // Record exists, switch to edit mode
                self?.isEditMode = true
                self?.registerButton.setTitle("Update", for: .normal)
                self?.loadExistingSkills()
            }
        }
    }
    
    private func loadExistingSkills() {
        let db = Firestore.firestore()
        db.collection("Skill").whereField("userID", isEqualTo: AccessManager.userID!).getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self,
                  let document = querySnapshot?.documents.first,
                  let skill1 = document.data()["skill1"] as? String,
                  let skill2 = document.data()["skill2"] as? String,
                  let skill3 = document.data()["skill3"] as? String,
                  let skill4 = document.data()["skill4"] as? String else {
                return
            }
            
            self.selectedSkills = [skill1, skill2, skill3, skill4]
            DispatchQueue.main.async {
                self.updateButtonAppearance()
                self.updateRegisterButtonState()
            }
        }
    }
    
    @objc private func skillButtonTapped(_ sender: UIButton) {
        guard let skillName = sender.titleLabel?.text else { return }
        
        if let index = selectedSkills.firstIndex(of: skillName) {
            // Deselect
            selectedSkills.remove(at: index)
            sender.backgroundColor = .systemGray5
            sender.setTitleColor(.black, for: .normal)
        } else if selectedSkills.count < maxSelections {
            // Select
            selectedSkills.append(skillName)
            sender.backgroundColor = .systemBlue
            sender.setTitleColor(.white, for: .normal)
        }
        
        updateRegisterButtonState()
    }
    
    private func updateButtonAppearance() {
        let allButtons: [UIButton] = [
            communication,
            projectManagement,
            problemSolving,
            TeamworkandCollaboration,
            dataAnalysis,
            leadership,
            timeManagement,
            technicalProficiency,
            customerService,
            adaptability,
            marketingAndSocialMedia,
            negotiation
        ]
        
        allButtons.forEach { button in
            if let title = button.titleLabel?.text,
               selectedSkills.contains(title) {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .systemGray5
                button.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    private func updateRegisterButtonState() {
        let isEnabled = selectedSkills.count == maxSelections
        registerButton.isEnabled = isEnabled
        registerButton.backgroundColor = isEnabled ? .systemBlue : .systemGray3
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard selectedSkills.count == 4 else {
            showAlert(message: "Please select exactly 4 skills")
            return
        }
        
        let db = Firestore.firestore()
        let skillsData: [String: Any] = [
            "userID": AccessManager.userID ?? "",
            "skill1": selectedSkills[0],
            "skill2": selectedSkills[1],
            "skill3": selectedSkills[2],
            "skill4": selectedSkills[3]
        ]
        
        if isEditMode {
            // Update existing document
            db.collection("Skill")
                .whereField("userID", isEqualTo: AccessManager.userID!)
                .getDocuments { [weak self] (querySnapshot, error) in
                    if let document = querySnapshot?.documents.first {
                        document.reference.updateData(skillsData) { error in
                            if let error = error {
                                self?.showAlert(message: "Error updating skills: \(error.localizedDescription)")
                            } else {
                                self?.showAlert(message: "Skills updated successfully!", title: "Success") {
                                    self?.navigationController?.popViewController(animated: true)
                                }
                            }
                        }
                    }
                }
        } else {
            // Add new document
            db.collection("Skill").addDocument(data: skillsData) { [weak self] error in
                if let error = error {
                    self?.showAlert(message: "Error saving skills: \(error.localizedDescription)")
                } else {
                    self?.showAlert(message: "Skills saved successfully!", title: "Success") {
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
    
    
    
}

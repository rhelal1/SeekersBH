//
//  InterestChoiceViewController.swift
//  SeekersBH
//
//

import UIKit
import Firebase

class InterestChoiceViewController: UIViewController {

    @IBOutlet weak var designCreativityBtn: UIButton!
    @IBOutlet weak var businessEntrepreneurshipBtn: UIButton!
    @IBOutlet weak var marketingGrowthBtn: UIButton!
    @IBOutlet weak var techDevelopmentBtn: UIButton!
    @IBOutlet weak var financeAccountingBtn: UIButton!
    @IBOutlet weak var salesCustomerSupportBtn: UIButton!
    @IBOutlet weak var humanResourcesBtn: UIButton!
    @IBOutlet weak var healthcareSciencesBtn: UIButton!
    @IBOutlet weak var educationLearningBtn: UIButton!
    @IBOutlet weak var legalComplianceBtn: UIButton!
    @IBOutlet weak var supplyChainBtn: UIButton!
    @IBOutlet weak var nonProfitImpactBtn: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var isEditMode: Bool = false
    
    private var selectedInterests: [String] = []  // Will store up to 4 interests in order
       private let maxSelections = 4
    var userID: String = AccessManager.userID!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("isEditMode set to: \(self.isEditMode)")
        if isEditMode {
                   // Change button text for edit mode
                   registerButton.setTitle("Update", for: .normal)
                   // Load existing interests
                   loadExistingInterests()
               }
        setupButtons()
               updateRegisterButtonState()
        
      
    }
    
    private func loadExistingInterests() {
        print("loading")
           let db = Firestore.firestore()
           db.collection("Interest")
            .whereField("userID", isEqualTo: AccessManager.userID!) // Changed from email
               .getDocuments { [weak self] (querySnapshot, error) in
               guard let self = self,
                     let document = querySnapshot?.documents.first,
                     let interest1 = document.data()["interest1"] as? String,
                     let interest2 = document.data()["interest2"] as? String,
                     let interest3 = document.data()["interest3"] as? String,
                     let interest4 = document.data()["interest4"] as? String else {
                   return
               }
                   
                   print(interest1)
               
               self.selectedInterests = [interest1, interest2, interest3, interest4]
               self.updateButtonAppearance()
           }
       }
    private func updateButtonAppearance() {
           let allButtons: [UIButton] = [
               techDevelopmentBtn,
               marketingGrowthBtn,
               businessEntrepreneurshipBtn,
               designCreativityBtn,
               financeAccountingBtn,
               salesCustomerSupportBtn,
               humanResourcesBtn,
               healthcareSciencesBtn,
               educationLearningBtn,
               legalComplianceBtn,
               supplyChainBtn,
               nonProfitImpactBtn
           ]
           
           allButtons.forEach { button in
               if let title = button.titleLabel?.text,
                  selectedInterests.contains(title) {
                   button.backgroundColor = .systemBlue
                   button.setTitleColor(.white, for: .normal)
               } else {
                   button.backgroundColor = .systemGray5
                   button.setTitleColor(.black, for: .normal)
               }
           }
       }
    
    // MARK: - Setup
        private func setupButtons() {
            let allButtons: [UIButton] = [
                techDevelopmentBtn,
                marketingGrowthBtn,
                businessEntrepreneurshipBtn,
                designCreativityBtn,
                financeAccountingBtn,
                salesCustomerSupportBtn,
                humanResourcesBtn,
                healthcareSciencesBtn,
                educationLearningBtn,
                legalComplianceBtn,
                supplyChainBtn,
                nonProfitImpactBtn
            ]
            
            allButtons.forEach { button in
                button.layer.cornerRadius = 12
                button.backgroundColor = .systemGray5
                button.addTarget(self, action: #selector(interestButtonTapped(_:)), for: .touchUpInside)
            }
            
            registerButton.isEnabled = false
            registerButton.backgroundColor = .systemGray3
            registerButton.layer.cornerRadius = 20
        }
        
        // MARK: - Actions
        @objc private func interestButtonTapped(_ sender: UIButton) {
            guard let interestName = sender.titleLabel?.text else { return }
            
            if let index = selectedInterests.firstIndex(of: interestName) {
                // Deselect
                selectedInterests.remove(at: index)
                sender.backgroundColor = .systemGray5
                sender.setTitleColor(.black, for: .normal)
            } else if selectedInterests.count < maxSelections {
                // Select
                selectedInterests.append(interestName)
                sender.backgroundColor = .systemBlue
                sender.setTitleColor(.white, for: .normal)
            }
            
            updateRegisterButtonState()
        }
        
        @IBAction func registerButtonTapped(_ sender: UIButton) {
            saveInterests()
        }
        
    private func saveInterests() {
           guard selectedInterests.count == 4 else {
               showAlert(message: "Please select exactly 4 interests")
               return
           }
           
           let db = Firestore.firestore()
           let interestsData: [String: Any] = [
            "userID": AccessManager.userID!, // Changed from email
               "interest1": selectedInterests[0],
               "interest2": selectedInterests[1],
               "interest3": selectedInterests[2],
               "interest4": selectedInterests[3]
           ]
           
           if isEditMode {
               // Update existing document
               db.collection("Interest")
                   .whereField("userID", isEqualTo: AccessManager.userID!) // Changed from email
                   .getDocuments { [weak self] (querySnapshot, error) in
                       if let document = querySnapshot?.documents.first {
                           document.reference.updateData(interestsData) { error in
                               if let error = error {
                                   self?.showAlert(message: "Error updating interests: \(error.localizedDescription)")
                               } else {
                                   self?.showAlert(message: "Interests updated successfully!", title: "Success") {
                                       self?.navigationController?.popViewController(animated: true)
                                   }
                               }
                           }
                       }
                   }
           } else {
               // Add new document
               db.collection("Interest").addDocument(data: interestsData) { [weak self] error in
                   if let error = error {
                       self?.showAlert(message: "Error saving interests: \(error.localizedDescription)")
                   } else {
                       self?.showAlert(message: "Interests saved successfully!", title: "Success") {
                           // Navigate or dismiss as needed
                       }
                   }
               }
           }
       }
   
        
        // MARK: - Helper Methods
        private func updateRegisterButtonState() {
            let isEnabled = selectedInterests.count == maxSelections
            registerButton.isEnabled = isEnabled
            registerButton.backgroundColor = isEnabled ? .systemBlue : .systemGray3
        }
        
        private func showAlert(message: String, title: String = "Error", completion: (() -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            })
            present(alert, animated: true)
        }
    }

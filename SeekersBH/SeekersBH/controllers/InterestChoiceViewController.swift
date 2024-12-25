//
//  InterestChoiceViewController.swift
//  SeekersBH
//
//  Created by Noora Qasim on 25/12/2024.
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
    
    
    
    private var selectedInterests: [String] = []  // Will store up to 4 interests in order
       private let maxSelections = 4
    var userEmail: String = User.loggedInUser;     override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
               updateRegisterButtonState()
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
        
        // MARK: - Firebase Operations
        private func saveInterests() {
            guard selectedInterests.count == 4 else {
                showAlert(message: "Please select exactly 4 interests")
                return
            }
            
            guard !userEmail.isEmpty else {
                showAlert(message: "User email not found")
                return
            }
            
            let db = Firestore.firestore()
            
            // Create document with exact field names matching the Firebase structure
            let interestsData: [String: Any] = [
                "email": userEmail,
                "interest1": selectedInterests[0],
                "interest2": selectedInterests[1],
                "interest3": selectedInterests[2],
                "interest4": selectedInterests[3]
            ]
            
            // Add to Interest collection
            db.collection("Interest").addDocument(data: interestsData) { [weak self] error in
                if let error = error {
                    self?.showAlert(message: "Error saving interests: \(error.localizedDescription)")
                } else {
                    self?.showAlert(message: "Interests saved successfully!", title: "Success") {
                        // Navigate to next screen
                        if let nextVC = self?.storyboard?.instantiateViewController(withIdentifier: "NextViewController") {
                            self?.navigationController?.pushViewController(nextVC, animated: true)
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

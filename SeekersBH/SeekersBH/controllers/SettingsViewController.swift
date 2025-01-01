//
//  SettingsViewController.swift
//  SeekersBH
//
//  Created by Noora Qasim on 27/12/2024.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var darkmode: UISwitch!
    @IBOutlet weak var editSkillsBtn: UIButton!
    @IBOutlet weak var editInterestBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
        setupDarkMode()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editInterestClicked(_ sender: Any) {
        performSegue(withIdentifier: "toInterestChoice", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toInterestChoice" {
                if let destinationVC = segue.destination as? InterestChoiceViewController {
                    destinationVC.isEditMode = true
                    print("isEditMode set to: \(destinationVC.isEditMode)")
                }
            }
        }

    
    private func setupButtons() {
          editInterestBtn.addTarget(self, action: #selector(editInterestsTapped), for: .touchUpInside)
      }
      
      @objc private func editInterestsTapped() {
          if let interestVC = storyboard?.instantiateViewController(withIdentifier: "InterestChoice") as? InterestChoiceViewController {
              interestVC.isEditMode = true  // Set it to edit mode
              print("isEditMode set to: \(interestVC.isEditMode)")
              navigationController?.pushViewController(interestVC, animated: true)
          }
      }
    
    private func setupDarkMode() {
            // Set initial switch state based on saved preference
            let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
            darkmode.isOn = isDarkMode
            
            // Apply the current theme
            applyTheme(isDarkMode: isDarkMode)
            
            // Add target for switch
            darkmode.addTarget(self, action: #selector(darkModeChanged), for: .valueChanged)
        }
        
        @objc private func darkModeChanged() {
            // Save the preference
            UserDefaults.standard.set(darkmode.isOn, forKey: "isDarkMode")
            
            // Apply the theme
            applyTheme(isDarkMode: darkmode.isOn)
        }
        
        private func applyTheme(isDarkMode: Bool) {
            if isDarkMode {
                // Apply dark theme
                if let window = view.window {
                    window.overrideUserInterfaceStyle = .dark
                }
                
                // Custom dark mode styling for this view controller
                view.backgroundColor = .systemBackground
                editSkillsBtn.backgroundColor = .systemGray6
                editInterestBtn.backgroundColor = .systemGray6
                editProfileBtn.backgroundColor = .systemGray6
                
                // Set text colors
                editSkillsBtn.setTitleColor(.white, for: .normal)
                editInterestBtn.setTitleColor(.white, for: .normal)
                editProfileBtn.setTitleColor(.white, for: .normal)
            } else {
                // Apply light theme
                if let window = view.window {
                    window.overrideUserInterfaceStyle = .light
                }
                
                // Custom light mode styling for this view controller
                view.backgroundColor = .systemBackground
                editSkillsBtn.backgroundColor = .systemGray5
                editInterestBtn.backgroundColor = .systemGray5
                editProfileBtn.backgroundColor = .systemGray5
                
                // Set text colors
                editSkillsBtn.setTitleColor(.black, for: .normal)
                editInterestBtn.setTitleColor(.black, for: .normal)
                editProfileBtn.setTitleColor(.black, for: .normal)
            }
        }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

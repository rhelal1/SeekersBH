//
//  SkillCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import UIKit

class SkillCVViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var skillName: UITextField!
    @IBOutlet weak var otherSkills: UITextField!
    
    let skills = [
        "Communication Skills",
        "Teamwork and Collaboration",
        "Problem-Solving",
        "Leadership",
        "Time Management",
        "Adaptability",
        "Critical Thinking",
        "Creativity",
        "Attention to Detail",
        "Organization",
        "Public Speaking",
        "Project Management",
        "Data Analysis",
        "Social Media Management",
        "Research Skills",
        "Marketing Skills",
        "Customer Service",
        "Writing and Editing",
        "Event Planning",
        "Microsoft Office (Word, Excel, PowerPoint)"
    ]
    var selectedSkills: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        skillName.inputView = pickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearButtonTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([clearButton, spacer, doneButton], animated: true)
        skillName.inputAccessoryView = toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return skills.count
    }
    
    // MARK: - UIPickerView Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return skills[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedSkill = skills[row]
        
        if !selectedSkills.contains(selectedSkill) {
            selectedSkills.append(selectedSkill)
        }
        
        skillName.text = selectedSkills.joined(separator: ", ")
    }
    
    @objc func doneButtonTapped() {
        skillName.resignFirstResponder()
    }
    
    @objc func clearButtonTapped() {
        selectedSkills.removeAll()
        skillName.text = ""
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if selectedSkills.isEmpty && (otherSkills.text?.isEmpty ?? true) {
            showAlert(message: "Please select at least one skill or enter other skills.")
            return
        }
        
        CVManager.shared.cv.skills = selectedSkills.joined(separator: ", ")
        CVManager.shared.cv.otherSkills = otherSkills.text ?? ""
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

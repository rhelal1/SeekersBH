//
//  EducationCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import UIKit

class EducationCVViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var highestDegreeField: UITextField!
    @IBOutlet weak var universityField: UITextField!
    
    
    // List of degree options
    let degreeOptions = ["High School", "Associate's Degree", "Bachelor's Degree", "Master's Degree", "Doctorate (PhD)"]
    var selectedDegree: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UIPickerView for the highestDegreeField text field
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Set pickerView as inputView for the highestDegreeField text field
        highestDegreeField.inputView = pickerView
        
        // Add a toolbar with a 'Done' button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        highestDegreeField.inputAccessoryView = toolbar
    }
    
    // MARK: - UIPickerView DataSource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Single column
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return degreeOptions.count
    }
    
    // MARK: - UIPickerView Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return degreeOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDegree = degreeOptions[row]
        highestDegreeField.text = selectedDegree // Update text field with selected degree
    }
    
    @objc func doneButtonTapped() {
        highestDegreeField.resignFirstResponder() // Dismiss picker view
    }
    
    @IBAction func nextButtonTabbed(_ sender: UIButton) {
        if highestDegreeField.text?.isEmpty ?? true {
            showAlert(message: "Highest degree field cannot be empty.")
            return
        }
        CVManager.shared.cv.highestDegree = highestDegreeField.text ?? ""
        // printing just to make sure it is saved
        print("Saved Highest Degree: \(CVManager.shared.cv.highestDegree)")
        
        if universityField.text?.isEmpty ?? true {
            showAlert(message: "University field cannot be empty.")
            return
        }
        CVManager.shared.cv.university = universityField.text ?? ""
        // printing just to make sure it is saved
        print("Saved University: \(CVManager.shared.cv.university)")
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

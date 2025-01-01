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
    
    let degreeOptions = ["High School", "Associate's Degree", "Bachelor's Degree", "Master's Degree", "Doctorate (PhD)"]
    var selectedDegree: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        highestDegreeField.inputView = pickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        highestDegreeField.inputAccessoryView = toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return degreeOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return degreeOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDegree = degreeOptions[row]
        highestDegreeField.text = selectedDegree
    }
    
    @objc func doneButtonTapped() {
        highestDegreeField.resignFirstResponder()
    }
    
    @IBAction func nextButtonTabbed(_ sender: UIButton) {
        if highestDegreeField.text?.isEmpty ?? true {
            showAlert(message: "Highest degree field cannot be empty.")
            return
        }
        CVManager.shared.cv.highestDegree = highestDegreeField.text ?? ""
        
        if universityField.text?.isEmpty ?? true {
            showAlert(message: "University field cannot be empty.")
            return
        }
        CVManager.shared.cv.university = universityField.text ?? ""
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

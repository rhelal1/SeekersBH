//
//  CertificationCVViewController.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import UIKit

class CertificationCVViewController: UIViewController {
    
    
    @IBOutlet weak var certificationName: UITextField!
    @IBOutlet weak var certificationDateObtained: UITextField!
    @IBOutlet weak var certificationIssuingOrganization: UITextField!
    @IBOutlet weak var otherCertification: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the date picker
        setupDatePicker()
    }
    
    func setupDatePicker() {
        // Configure date picker
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en_US")
        datePicker.preferredDatePickerStyle = .wheels
        
        // Add the date picker as the input view for the certificationDateObtained text field
        certificationDateObtained.inputView = datePicker
        
        // Add a toolbar for "Done" and "Cancel" actions
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Done button to dismiss date picker
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.setItems([doneButton], animated: false)
        
        certificationDateObtained.inputAccessoryView = toolbar
    }
    
    @objc func doneTapped() {
        // When the done button is tapped, set the text field to the selected date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        certificationDateObtained.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true) // Dismiss the keyboard
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        // Validate inputs
        if certificationName.text?.isEmpty ?? true {
            showAlert(message: "Certification name cannot be empty.")
            return
        }
        
        if certificationDateObtained.text?.isEmpty ?? true {
            showAlert(message: "Certification date obtained cannot be empty.")
            return
        }
        
        guard let certificationDateString = certificationDateObtained.text,
              let certificationDate = isValidDate(certificationDateString) else {
            showAlert(message: "Please enter a valid date in MM/DD/YYYY format.")
            return
        }
        
        if certificationDate > Date() {
            showAlert(message: "Certification date cannot be in the future.")
            return
        }
        
        if certificationIssuingOrganization.text?.isEmpty ?? true {
            showAlert(message: "Certification issuing organization cannot be empty.")
            return
        }
        
        // Proceed with saving the certification
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = dateFormatter.string(from: certificationDate)
        
        let newCertification = Certification(
            name: certificationName.text ?? "",
            DateObtained: certificationDate,
            IssuingOrganization: certificationIssuingOrganization.text ?? ""
        )
        
        // Save the certification (printing for debugging)
        print("Saved Certification: \(newCertification.name), Date Obtained: \(formattedDate), Issuing Organization: \(newCertification.IssuingOrganization)")
        
        CVManager.shared.cv.certifications.append(newCertification)
        CVManager.shared.cv.otherCertification = otherCertification.text ?? ""
        
        // Save other certifications (printing for debugging)
        print("Saved other certifications: \(CVManager.shared.cv.otherCertification)")
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func isValidDate(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.date(from: dateString)
    }
}

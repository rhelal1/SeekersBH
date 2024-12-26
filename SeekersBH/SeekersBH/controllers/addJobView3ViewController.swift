import UIKit

class addJobView3ViewController: UIViewController {
    var coordinator: AddEditJobCoordinator? // Added coordinator for mode handling
    @IBOutlet weak var applicationdeadline: UIDatePicker!
    @IBOutlet weak var AdditionalPerksTxtView: UITextView!
    @IBOutlet weak var salaryRangetxtField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    var job: JobAd? // Receive JobAd object
    
    @IBOutlet weak var vieww: UIView!
    @IBOutlet weak var textview1: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vieww.layer.cornerRadius = 10
        textview1.layer.cornerRadius = 10
        
        // Ensure the date picker starts from tomorrow's date
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        applicationdeadline.minimumDate = tomorrow
        
        // Populate UI with job data if editing
        if let job = job {
            salaryRangetxtField.text = job.jobSalary
            AdditionalPerksTxtView.text = job.additionalPerks.joined(separator: ", ")
            applicationdeadline.date = job.jobApplicationDeadline
        }
        setupKeyboard()
        setupPage()
    }
    
    private func setupPage() {
        if let coordinator = coordinator, case .edit(let job) = coordinator.mode {
            setupForEditMode(with: job)
        }
    }
    
    private func setupForEditMode(with job: JobAd) {
        titleLabel.text = "Edit Job Details"
        populateFields(with: job)
    }
    
    private func populateFields(with job: JobAd) {

        applicationdeadline.setDate(job.jobApplicationDeadline,animated: false)
        AdditionalPerksTxtView.text = job.additionalPerks.joined(separator: ", ")
        salaryRangetxtField.text = job.jobSalary
        
       
    }
    
    @IBAction func finishbtn(_ sender: UIButton) {
        if validateInput() {
            saveJob()
        }
    }
    
    private func setupKeyboard() {
         view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing)))
         
         [UIResponder.keyboardWillShowNotification, UIResponder.keyboardWillHideNotification].forEach { notification in
             NotificationCenter.default.addObserver(forName: notification, object: nil, queue: .main) { [weak self] _ in
                 UIView.animate(withDuration: 0.3) {
                     self?.view.frame.origin.y = notification == UIResponder.keyboardWillShowNotification ? -100 : 0
                 }
             }
         }
     }
    private func saveJob() {
        // Prepare common job data
        var jobData: [String: Any] = [
            "jobSalary": salaryRangetxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            "jobApplicationDeadline":  applicationdeadline.date,
            "additionalPerks": AdditionalPerksTxtView.text
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: ",")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }, // Remove empty strings
            "datePosted": Date(),
            "status": "Open",
            "applicationStatus": "pending"
        ]
        
        // Handle add or edit mode
        switch coordinator?.mode {
        case .add:
            // Adding a new job
            // Include additional fields specific to adding if necessary
            FirebaseManager.shared.addDocumentToCollection_qassim(collectionName: "jobs", data: jobData) { [weak self] error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.showAlert(message: "Failed to save job: \(error.localizedDescription)")
                    } else {
                        self?.showAlert(title: "Success", message: "Job added successfully.") {
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
            
        case .edit(let existingJob):
            // Updating an existing job
            // Include fields that can be updated
            jobData["jobName"] = existingJob.jobName
            jobData["jobLocation"] = existingJob.jobLocation
            jobData["jobType"] = existingJob.jobType.rawValue
            jobData["jobDescription"] = existingJob.jobDescription
            jobData["jobKeyResponsibilites"] = existingJob.jobKeyResponsibilites
            jobData["jobQualifications"] = existingJob.jobQualifications
            jobData["jobEmploymentBenfits"] = existingJob.jobEmploymentBenfits
            jobData["applicants"] = existingJob.applicants
            
            // Ensure documentId is available
            guard let documentId = existingJob.documentId else {
                self.showAlert(title: "Invalid Update" ,message: "Unable to update job: Missing document ID.")
                return
            }
            
            FirebaseManager.shared.updateDocument(collectionName: "jobs", documentId: documentId, data: jobData) { [weak self] error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.showAlert(title:"Database error",message: "Failed to update job: \(error.localizedDescription)")
                    } else {
                        self?.showAlert(title: "Success", message: "Job updated successfully.") {
                            self?.performSegue(withIdentifier: "goToNextPage", sender: nil)
                        }
                    }
                }
            }
            
        case .none:
            // Handle the case where mode is not set
            showAlert(title:"Invalid Mode",message: "Unable to determine the mode for saving the job.")
        }
    }


    private func showAlert(title: String = "Error", message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Validation function
    private func validateInput() -> Bool {
        // Validate salary range
        if !validateSalaryRange() {
             return false
         }
        
        // Validate application deadline
        let today = Calendar.current.startOfDay(for: Date())
        let selectedDeadline = Calendar.current.startOfDay(for: applicationdeadline.date)
        if selectedDeadline <= today {
            showValidationAlert(message: "The application deadline must be at least one day after today.")
            return false
        }
        
        // Validate additional perks for alphabetic characters only
        let additionalPerksText = AdditionalPerksTxtView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let perksPattern = #"^[a-zA-Z\s,]*$"#
        if !additionalPerksText.isEmpty && !NSPredicate(format: "SELF MATCHES %@", perksPattern).evaluate(with: additionalPerksText) {
            showValidationAlert(message: "Please enter valid additional perks.")
            return false
        }
        
        return true
    }
    

    private func validateSalaryRange() -> Bool {
        guard let salaryRange = salaryRangetxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !salaryRange.isEmpty else {
            showValidationAlert(message: "Salary range cannot be empty.")
            return false
        }
        
        // Updated regex pattern to allow optional dollar signs
        let salaryRangePattern = #"^\$?\d{1,6}(-\$?\d{1,6})?$"#
        
        // Validate the pattern
        let regexTest = NSPredicate(format: "SELF MATCHES %@", salaryRangePattern)
        if !regexTest.evaluate(with: salaryRange) {
            showValidationAlert(message: "Salary range must be a number or in the format 'min-max' (e.g., 3000-5000).")
            return false
        }
        
        // Remove dollar signs and split by '-'
        let cleanedSalaryRange = salaryRange.replacingOccurrences(of: "$", with: "")
        let salaryParts = cleanedSalaryRange.components(separatedBy: "-")
        
        // Iterate through each part and validate
        for part in salaryParts {
            if let salary = Int(part) {
                if salary >= 10000 {
                    showValidationAlert(message: "Each salary amount must be less than $10,000.")
                    return false
                }
            } else {
                // This should not happen due to regex, but added for safety
                showValidationAlert(message: "Invalid salary number.")
                return false
            }
        }
        
        return true
    }

    
    // Alert function for validation errors
    private func showValidationAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

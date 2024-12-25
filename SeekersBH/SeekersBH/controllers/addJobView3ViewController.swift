import UIKit

class addJobView3ViewController: UIViewController {
    var coordinator: AddEditJobCoordinator? // Added coordinator for mode handling
    @IBOutlet weak var applicationdeadline: UIDatePicker!
    @IBOutlet weak var AdditionalPerksTxtView: UITextView!
    @IBOutlet weak var salaryRangetxtField: UITextField!
    var job: JobAd? // Receive JobAd object
    
    @IBOutlet weak var vieww: UIView!
    @IBOutlet weak var textview1: UITextView!
    
    var isSegueAlreadyPerformed = false
    
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
    }
    
    @IBAction func finishbtn(_ sender: UIButton) {
        if validateInput() {
            showAlert()
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

        var jobData: [String: Any] = [
              "jobSalary": salaryRangetxtField.text ?? "",
              "jobApplicationDeadline": applicationdeadline.date,
              "additionalPerks": AdditionalPerksTxtView.text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ","),
              "datePosted": Date(),
              "status": "Open",
              "applicationStatus": "pending"
          ]
          
          // Add existing job data if we're updating
          if let existingJob = job {
              jobData["jobName"] = existingJob.jobName
              jobData["jobLocation"] = existingJob.jobLocation
              jobData["jobType"] = existingJob.jobType.rawValue
              jobData["jobDescription"] = existingJob.jobDescription
              jobData["jobKeyResponsibilites"] = existingJob.jobKeyResponsibilites
              jobData["jobQualifications"] = existingJob.jobQualifications
              jobData["jobEmploymentBenfits"] = existingJob.jobEmploymentBenfits
              jobData["applicants"] = existingJob.applicants
          }
          
          // Save to Firebase
          FirebaseManager.shared.addDocumentToCollection(collectionName: "jobs", data: jobData)
    }

    
    private func showAlert() {
        // Create the alert controller
        let alert = UIAlertController(title: "", message: "Job Application added Successfully", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Done", style: .default) { _ in
            // Ensure you’re only performing the segue once
            if !self.isSegueAlreadyPerformed {
                self.isSegueAlreadyPerformed = true
                self.performSegue(withIdentifier: "goToNextPage", sender: self)
            }
        }
        
        // Add the action to the alert
        alert.addAction(okAction)
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // Validation function
    private func validateInput() -> Bool {
        // Validate salary range
        guard let salaryRange = salaryRangetxtField.text,
              !salaryRange.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showValidationAlert(message: "Salary range cannot be empty.")
            return false
        }
        
        // Check if the salary range is numeric or matches a range format
        let salaryRangePattern = #"^\d{1,6}-\d{1,6}$|^\d{1,6}$"#
        if !NSPredicate(format: "SELF MATCHES %@", salaryRangePattern).evaluate(with: salaryRange) {
            showValidationAlert(message: "Salary range must be a number or in the format 'min-max' (e.g., 3000-5000).")
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
    
    // Alert function for validation errors
    private func showValidationAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

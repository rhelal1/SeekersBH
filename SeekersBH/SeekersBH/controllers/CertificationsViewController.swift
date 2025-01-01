import UIKit

class CertificationsViewController: UIViewController {

    @IBOutlet weak var certificateTable: UITableView!
    var courseCertification: [CourseCertification] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCertifications()
        
        certificateTable.dataSource = self
        certificateTable.delegate = self
    }
    
    private func fetchCertifications() {
        Task {
            do {
                self.courseCertification = try await CourseManager.share.fetchCertifications(for: AccessManager.userID!)
                DispatchQueue.main.async {
                    self.certificateTable.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
        }
    }

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension CertificationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseCertification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "certificateCell", for: indexPath) as! CertificationsTableViewCell
        cell.update(with: courseCertification[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCertificate = courseCertification[indexPath.row]

         //Instantiate the CertificateManageViewController
        if let certificateDetailsVC = storyboard?.instantiateViewController(withIdentifier: "CertificateManageViewController") as? CertificateManageViewController {
            // Pass the selected article to the CertificateManageViewController
            certificateDetailsVC.certificate = selectedCertificate

            // Push the detail view controller
            navigationController?.pushViewController(certificateDetailsVC, animated: true)
        }
    }
}

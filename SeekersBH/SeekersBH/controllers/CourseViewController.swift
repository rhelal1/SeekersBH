import UIKit

class CourseViewController: UIViewController {

    
    @IBOutlet weak var courseTable: UITableView!
    
    var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCourses()
        
        courseTable.dataSource = self
        courseTable.delegate = self
    }
    
    func fetchCourses() {
        Task {
            do {
                self.courses = try await CourseManager.share.fetchAllCourses()
                
                DispatchQueue.main.async {
                    self.courseTable.reloadData()
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

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseTableViewCell

        cell.update(with: courses[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Optional: remove separator lines (if not needed)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCourse = courses[indexPath.row]

        // Instantiate the CourseDetailsViewController
        if let courseDetailsVC = storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as? CourseDetailsViewController {
            // Pass the selected course to the CourseDetailsViewController
            courseDetailsVC.course = selectedCourse

            // Push the detail view controller
            navigationController?.pushViewController(courseDetailsVC, animated: true)
        }
    }
}

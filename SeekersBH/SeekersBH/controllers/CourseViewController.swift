import UIKit

class CourseViewController: UIViewController {

    
    @IBOutlet weak var courseTable: UITableView!
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    var courses: [Course] = []
    var filteredCourses: [Course] = [] // Courses filtered by category
    
    @IBAction func segmentChange(_ sender: Any) {
        filterCoursesByCategory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCourses()
        
        courseTable.dataSource = self
        courseTable.delegate = self
        
        // Set up the initial filter based on the default selected segment
        filterCoursesByCategory()
    }
    
    func fetchCourses() {
        Task {
            do {
                self.courses = try await CourseManager.share.fetchAllCourses()
                
                DispatchQueue.main.async {
                    self.filterCoursesByCategory() // Filter after fetching
                    self.courseTable.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
        }
    }
    
    private func filterCoursesByCategory() {
            // Determine the selected category
            let selectedIndex = categorySegment.selectedSegmentIndex
            let selectedCategory: CourseCategory?

            switch selectedIndex {
                case 0: selectedCategory = nil // "All" or default segment
                case 1: selectedCategory = .technology
                case 2: selectedCategory = .business
                case 3: selectedCategory = .economics
                default: selectedCategory = nil
            }

            // Filter courses based on the selected category
            if let category = selectedCategory {
                filteredCourses = courses.filter { $0.category == category }
            } else {
                filteredCourses = courses // Show all courses
            }

            // Reload the table with the filtered courses
            courseTable.reloadData()
        }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseTableViewCell

        cell.update(with: filteredCourses[indexPath.row])
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
        let selectedCourse = filteredCourses[indexPath.row]

        // Instantiate the CourseDetailsViewController
        if let courseDetailsVC = storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as? CourseDetailsViewController {
            // Pass the selected course to the CourseDetailsViewController
            courseDetailsVC.course = selectedCourse

            // Push the detail view controller
            navigationController?.pushViewController(courseDetailsVC, animated: true)
        }
    }
}

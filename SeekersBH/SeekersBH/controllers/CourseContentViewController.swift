import UIKit

class CourseContentViewController: UIViewController {
    
    @IBOutlet weak var courseContentTable: UITableView!
    
    var courseContents: [CourseContent]!
    var quize : [Question]!
    
    @IBAction func StartQuize(_ sender: Any) {
        // Instantiate the CourseQuizViewController
        if let courseQuizVC = storyboard?.instantiateViewController(withIdentifier: "CourseQuizViewController") as? CourseQuizViewController {
            
            // Pass the selected course to the CourseQuizViewController
            courseQuizVC.quizeQuestions = quize

            // Push the detail view controller
            navigationController?.pushViewController(courseQuizVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseContentTable.dataSource = self
        courseContentTable.delegate = self
    }

}


extension CourseContentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseContentCell", for: indexPath) as! CourseContentTableViewCell

        cell.update(with: courseContents[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContent = courseContents[indexPath.row]
        print(selectedContent.videoUrl)
    }
}

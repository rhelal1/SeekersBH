import UIKit

class CourseContentViewController: UIViewController {
    
    @IBOutlet weak var courseContentTable: UITableView!
    
    var course : Course!
    
    @IBAction func StartQuize(_ sender: Any) {
        // Instantiate the CourseQuizViewController
        if let courseQuizVC = storyboard?.instantiateViewController(withIdentifier: "CourseQuizViewController") as? CourseQuizViewController {
            
            // Pass the selected course to the CourseQuizViewController
            courseQuizVC.course = course

            courseQuizVC.modalPresentationStyle = .fullScreen
            present(courseQuizVC, animated: true, completion: nil)
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
        return course.courseContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseContentCell", for: indexPath) as! CourseContentTableViewCell

        cell.update(with: course.courseContent[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContent = course.courseContent[indexPath.row]

        // Initialize the VideoPlayerViewController
        let videoPlayerVC = VideoPlayerViewController()
            videoPlayerVC.videoUrl = URL(string: selectedContent.videoUrl)


        // Navigate to the VideoPlayerViewController
        self.navigationController?.pushViewController(videoPlayerVC, animated: true)

    }
}

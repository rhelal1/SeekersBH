import UIKit

class CourseReviewViewController: UIViewController {
    
    var courseComments : [CourseComments]!
    var ratingText : String!

    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var commentsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTable.delegate = self
        commentsTable.dataSource = self
        
        ratingView.layer.cornerRadius = 15
        rating.text = ratingText
    }
}

extension CourseReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCommentCell", for: indexPath) as! CourseReviewTableViewCell

        cell.update(with: courseComments[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = courseComments[indexPath.row]
    }
}

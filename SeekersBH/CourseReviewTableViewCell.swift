import UIKit

class CourseReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var imageW: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with courseConment: CourseComments) {
        imageW.image = UIImage(named: "user")
        imageW.layer.cornerRadius = imageW.frame.size.height / 2
        imageW.clipsToBounds = true
        imageW.contentMode = .scaleAspectFill
        
        updateUsername(userId: courseConment.userId)
        
        comment.text = courseConment.commenttext
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }
    
    func updateUsername(userId : String) {
        Task {
            do {
                let usernames = try await CourseManager.share.fetchUsername(userId: userId)
                username.text = usernames
            } catch {
                username.text = "user123"
                print("Error fetching username: \(error.localizedDescription)")
            }
        }
    }

}

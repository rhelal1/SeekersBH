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
        imageW.image = UIImage(named: "imageTest2") // "imageTest" should change to "webinar.picture" later
        imageW.layer.cornerRadius = imageW.frame.width / 2
        
        username.text = courseConment.username
        comment.text = courseConment.commenttext
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }

}

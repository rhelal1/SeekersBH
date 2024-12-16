import UIKit

class CourseContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageW: UIImageView!
    @IBOutlet weak var contentDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with courseContent: CourseContent) {
        imageW.image = UIImage(named: "imageTest2") // "imageTest" should change to "webinar.picture" later
        imageW.layer.cornerRadius = imageW.frame.width / 2
        
        title.text = courseContent.title
        contentDescription.text = courseContent.description
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }
}

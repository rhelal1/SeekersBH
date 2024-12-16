import UIKit

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var imageW: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with course: Course) {
        imageW.image = UIImage(named: "imageTest2") // "imageTest" should change to "webinar.picture" later
        
        title.text = course.title

        imageW.layer.cornerRadius = 15
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }

}

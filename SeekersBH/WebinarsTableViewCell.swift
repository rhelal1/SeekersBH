import UIKit

class WebinarsTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var imageW: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with webinar: Webinar) {
        imageW.image = UIImage(named: "imageTest2") // "imageTest" should change to "webinar.picture" later
        
        title.text = webinar.title
        descriptions.text = webinar.description
    
        imageW.layer.cornerRadius = 15

        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }
}

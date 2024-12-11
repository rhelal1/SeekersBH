import UIKit

class WebinarDetailsViewController: UIViewController {
    
    var webinar : Webinar!

    @IBOutlet weak var genralView: UIView!
    @IBOutlet weak var descrView: UIView!
    @IBOutlet weak var imageW: UIImageView!
    
    @IBOutlet weak var webinarTitle: UILabel!
    @IBOutlet weak var speaker: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var webinarDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genralView.layer.cornerRadius = 15
        genralView.layer.masksToBounds = true
        
        descrView.layer.cornerRadius = 15
        descrView.layer.masksToBounds = true
        
        imageW.layer.cornerRadius = 15
        
        webinarTitle.text = webinar.title
        speaker.text = webinar.speaker
        date.text = "\(webinar.date)"
        time.text = "\(webinar.timeZone)"
        imageW.image = UIImage(named: "imageTest2")
        
        webinarDescription.text = webinar.description
    }
}

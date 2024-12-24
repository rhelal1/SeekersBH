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
        time.text = webinar.timeZone
        imageW.image = UIImage(named: "imageTest2")
        
        webinarDescription.text = webinar.description
    }

    @IBAction func joinWebinar(_ sender: Any) {
        guard let url = URL(string: webinar.url), UIApplication.shared.canOpenURL(url) else {
            let alert = UIAlertController(title: "Invalid URL", message: "The URL provided is not valid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func SaveResourceButtonTapped(_ sender: Any) {
        let savedResource = SavedResource(resource: webinar, type: .webinar)
        
        // Save resource to Firebase
        ResourceManager.share.saveResourceToFirebase(userID: AccessManager.userID!, resourceId: webinar.id, resourceType: .webinar, viewController: self)
    }
    
}

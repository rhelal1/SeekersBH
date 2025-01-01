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
        // Load the image asynchronously
        if let imageUrl = URL(string: webinar.picture) {
                // Perform the network request asynchronously
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let error = error {
                        print("Error loading image: \(error.localizedDescription)")
                        return
                    }
                    
                    // Ensure data is available and it is valid
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            // Update the image view on the main thread
                            self.imageW.image = image
                        }
                    }
                }.resume()
            }
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
        // Save resource to Firebase
        ResourceManager.share.saveResourceToFirebase(userID: AccessManager.userID!, resourceId: webinar.id, resourceType: .webinar, viewController: self)
    }
    
}

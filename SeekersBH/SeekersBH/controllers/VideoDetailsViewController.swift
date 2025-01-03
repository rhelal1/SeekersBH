import UIKit

class VideoDetailsViewController: UIViewController {
    
    var video : Video!

    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var descrView: UIView!
    
    @IBOutlet weak var imageW: UIImageView!
    
    @IBOutlet weak var videoTitle: UILabel!    
    @IBOutlet weak var speaker: UILabel!
    @IBOutlet weak var channel: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generalView.layer.cornerRadius = 15
        generalView.layer.masksToBounds = true
        
        descrView.layer.cornerRadius = 15
        descrView.layer.masksToBounds = true
        
        imageW.layer.cornerRadius = 15
        
        videoTitle.text = video.title
        speaker.text = video.speaker
        channel.text = video.channel
        duration.text = "\(video.duration)"
        // Load the image asynchronously
        if let imageUrl = URL(string: video.picture) {
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
        videoDescription.text = video.description
    }
    
    @IBAction func WatchNow(_ sender: Any) {
        guard let url = URL(string: video.url), UIApplication.shared.canOpenURL(url) else {
            let alert = UIAlertController(title: "Invalid URL", message: "The URL provided is not valid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    

    @IBAction func savedResourceButtonTapped(_ sender: Any) {     

        // Save resource to Firebase
        ResourceManager.share.saveResourceToFirebase(userID: AccessManager.userID!, resourceId: video.id, resourceType: .video, viewController: self)
    }
    
}

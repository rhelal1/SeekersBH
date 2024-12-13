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
        imageW.image = UIImage(named: "imageTest2")
        
        videoDescription.text = video.description
    }
}

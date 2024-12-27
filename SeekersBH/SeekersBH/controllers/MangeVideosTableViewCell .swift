import UIKit

class MangeVideosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var video: Video?
    
    // Closure to handle visibility toggle
    var toggleVisibilityAction: ((String, Bool) -> Void)?
    
    func update(with video: Video) {
        self.video = video
        titleLabel.text = video.title
        descriptionLabel.text = video.description
        actionButton.setTitle(video.isHidden ? "Unhide" : "Hide", for: .normal)
    }
    
    @IBAction func didTapActionButton(_ sender: Any) {
        guard let videoID = video?.id else { return }
        
        let newHiddenState = !(video?.isHidden ?? false)
        
        // Invoke the closure
        toggleVisibilityAction?(videoID, newHiddenState)
    }
}

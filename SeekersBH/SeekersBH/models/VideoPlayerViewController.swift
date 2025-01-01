import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {

    var videoUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        guard let videoUrl = videoUrl else {
            print("Invalid video URL")
            return
        }

        // Create an AVPlayer instance
        let player = AVPlayer(url: videoUrl)

        // Create an AVPlayerLayer to display the video
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        // Add AVPlayerViewController as a child view controller
        self.addChild(playerViewController)
        playerViewController.view.frame = self.view.bounds
        self.view.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)

        // Start playing the video
        player.play()
    }

}

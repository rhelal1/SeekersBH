//
//  MangeVideosTableViewCell.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//

import UIKit

class MangeVideosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var video: Video?
    
    func update(with video: Video) {
        self.video = video
           titleLabel.text = video.title
           descriptionLabel.text = video.description
        actionButton.setTitle(video.isHidden ? "Unhide" : "Hide", for: .normal)

       }
    
    @IBAction func didTapActionButton(_ sender: Any) {
        guard let parentVC = self.parentViewController as? MangeVideosViewController,
                    let videoID = video?.id else { return }
              let newHiddenState = !(video?.isHidden ?? false)
        
//        print("Video tapped: \(videoID)")

              FirebaseManager.shared.updateDocument(
                  collectionName: "Videos",
                  documentId: videoID,
                  data: ["isHidden": newHiddenState]
              ) { error in
                  if let error = error {
                      print("Failed to update visibility: \(error.localizedDescription)")
                  } else {
                      self.video?.isHidden = newHiddenState
                      self.actionButton.setTitle(newHiddenState ? "Unhide" : "Hide", for: .normal)
                      parentVC.updateVideoVisibility(videoID: videoID, isHidden: newHiddenState)
                  }
              }
    }
}

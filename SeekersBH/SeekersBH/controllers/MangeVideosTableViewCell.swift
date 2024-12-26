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
    @IBOutlet weak var vidcover: UIImageView!
    func update(with video: Video) {
        titleLabel.text = video.title
        descriptionLabel.text = video.description
        
        if let imageURL = URL(string: video.picture) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.vidcover.image = image
                    }
                }
            }
        } else {
            vidcover.image = UIImage(named: "placeholder")
        }
    }
}

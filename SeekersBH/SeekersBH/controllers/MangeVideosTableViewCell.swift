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
   
    func update(with video: Video) {
           titleLabel.text = video.title
           descriptionLabel.text = video.description
       }
}

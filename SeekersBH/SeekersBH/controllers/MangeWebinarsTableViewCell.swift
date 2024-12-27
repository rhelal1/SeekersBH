//
//  MangeWebinarsTableViewCell.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//

import UIKit


class MangeWebinarsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
//    @IBOutlet weak var descriptionLabel: UILabel!
   
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func update(with webinar: Webinar) {
        titleLabel.text = webinar.title
        descriptionLabel.text = webinar.description
    }
}

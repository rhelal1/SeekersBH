//
//  MangeWebinarsTableViewCell.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//

import UIKit


class MangeWebinarsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var webinar: Webinar?
    
    var toggleVisibilityAction: ((String, Bool) -> Void)?
    
    func update(with webinar: Webinar) {
        self.webinar = webinar
                titleLabel.text = webinar.title
                descriptionLabel.text = webinar.description
                actionButton.setTitle(webinar.isHidden ? "Unhide" : "Hide", for: .normal)
    }
    
    
    @IBAction func didTapActionButton(_ sender: Any) {
        guard let webinarID = webinar?.id else { return }
               
               let newHiddenState = !(webinar?.isHidden ?? false)
               toggleVisibilityAction?(webinarID, newHiddenState)
    }
    
}

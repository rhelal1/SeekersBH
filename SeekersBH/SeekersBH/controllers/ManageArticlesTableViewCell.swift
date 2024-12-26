//
//  ManageArticlesTableViewCell.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//

import UIKit

import UIKit

class ManageArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func update(with article: Article) {
        if let titleLabel = titleLabel, let descriptionLabel = descriptionLabel {
            titleLabel.text = article.title
            descriptionLabel.text = article.description
        } else {
            print("Error: Labels are not connected")
        }
    }
    
    
}


//
//  ManageArticlesTableViewCell.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//

import UIKit

import UIKit

class ManageArticlesTableViewCell: UITableViewCell {
    
    var article: Article?
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    func update(with article: Article) {
        self.article = article
        if let titleLabel = titleLabel, let descriptionLabel = descriptionLabel {
            titleLabel.text = article.title
            descriptionLabel.text = article.description
            actionButton.setTitle(article.isHidden ? "Unhide" : "Hide", for: .normal)
        } else {
            print("Error: Labels are not connected")
        }
    }
    @IBAction func didTapActionButton(_ sender: Any) {
        guard let parentVC = self.parentViewController as? ManageArticlesViewController,
                 let articleID = article?.id else { return }
           
           let newHiddenState = !(article?.isHidden ?? false)
           
           FirebaseManager.shared.updateDocument(
               collectionName: "Article",
               documentId: articleID,
               data: ["isHidden": newHiddenState]
           ) { error in
               if let error = error {
                   print("Failed to update visibility: \(error.localizedDescription)")
               } else {
                   self.article?.isHidden = newHiddenState
                   self.actionButton.setTitle(newHiddenState ? "Unhide" : "Hide", for: .normal)
                   parentVC.updateArticleVisibility(articleID: articleID, isHidden: newHiddenState)
                           }
               }
           }
    }






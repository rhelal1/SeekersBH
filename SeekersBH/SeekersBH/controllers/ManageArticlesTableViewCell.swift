import UIKit

class ManageArticlesTableViewCell: UITableViewCell {
    
    var article: Article?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var toggleVisibilityAction: ((String, Bool) -> Void)?
    
    func update(with article: Article) {
        self.article = article
        
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        actionButton.setTitle(article.isHidden ? "Unhide" : "Hide", for: .normal)
    }
    
    @IBAction func didTapActionButton(_ sender: Any) {
        guard let articleID = article?.id else { return }
        
        let newHiddenState = !(article?.isHidden ?? false)
        
        toggleVisibilityAction?(articleID, newHiddenState)
    }
}

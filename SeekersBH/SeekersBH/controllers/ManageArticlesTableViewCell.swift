import UIKit

class ManageArticlesTableViewCell: UITableViewCell {
    
    var article: Article?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    // Closure property for handling visibility toggle
    var toggleVisibilityAction: ((String, Bool) -> Void)?
    
    // Update cell content
    func update(with article: Article) {
        self.article = article
        
        // Update UI elements
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        actionButton.setTitle(article.isHidden ? "Unhide" : "Hide", for: .normal)
    }
    
    // Handle button tap
    @IBAction func didTapActionButton(_ sender: Any) {
        guard let articleID = article?.id else { return }
        
        // Toggle visibility state
        let newHiddenState = !(article?.isHidden ?? false)
        
        // Invoke the closure
        toggleVisibilityAction?(articleID, newHiddenState)
    }
}

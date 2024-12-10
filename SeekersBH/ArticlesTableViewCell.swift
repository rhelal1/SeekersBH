import UIKit

class ArticlesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func update(with article: Article) {
        views.text = "Views: \(article.views)"
        title.text = article.title
        descriptions.text = article.description
        stackView.layer.cornerRadius = 15
        stackView.layer.masksToBounds = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var views: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with article: Article) {
        views.text = "Views: \(article.views)"
        title.text = article.title
        descriptions.text = article.description
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }

}

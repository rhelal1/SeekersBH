import UIKit

class ArticleDetailsViewController: UIViewController {
    
    var article : Article!
 
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var descrView: UIView!
    
    @IBOutlet weak var AutherName: UILabel!
    @IBOutlet weak var yearOfPublishing: UILabel!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var DOI: UILabel!
    
    @IBOutlet weak var articleTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generalView.layer.cornerRadius = 15
        generalView.layer.masksToBounds = true
        
        descrView.layer.cornerRadius = 15
        descrView.layer.masksToBounds = true
        
        articleTitle.text = article.title
        AutherName.text = article.author
        yearOfPublishing.text = "\(article.yearOfPublication)"
        publisher.text = article.publisher
        DOI.text = article.DOI
        
        articleDescription.text = article.description
    }
}

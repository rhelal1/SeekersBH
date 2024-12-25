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
    
    
    @IBAction func readMore(_ sender: Any) {
        guard let url = URL(string: article.url), UIApplication.shared.canOpenURL(url) else {
            let alert = UIAlertController(title: "Invalid URL", message: "The URL provided is not valid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func savedResourceButtonTspped(_ sender: Any) {
        // Save resource to Firebase
        ResourceManager.share.saveResourceToFirebase(userID: AccessManager.userID!, resourceId: article.id, resourceType: .article, viewController: self)
    }
    
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
        
        // Increment views when the page is loaded
        ResourceManager.share.incrementViews(forArticleId: article.id) { error in
            if let error = error {
                print("Failed to update views: \(error.localizedDescription)")
            }
        }
    }

}

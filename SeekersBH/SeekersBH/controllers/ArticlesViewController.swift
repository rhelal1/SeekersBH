import UIKit

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var articleTable: UITableView!
    
    var articles: [Article] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        fetchArticles()
        
        articleTable.dataSource = self
        articleTable.delegate = self
    }
    
    private func fetchArticles() {
        Task {
            do {
                self.articles = try await ResourceManager.share.fetchArticles()
                DispatchQueue.main.async {
                    self.articleTable.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticlesTableViewCell

        cell.update(with: articles[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]

        // Instantiate the ArticleDetailsViewController
        if let articleDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController {
            // Pass the selected article to the ArticleDetailsViewController
            articleDetailsVC.article = selectedArticle

            // Push the detail view controller
            navigationController?.pushViewController(articleDetailsVC, animated: true)
        }
    }
}

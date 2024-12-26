//
//  MangeArticlesViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//

import UIKit

class ManageArticlesViewController: UIViewController {

    
    @IBOutlet weak var manageArticlesTable: UITableView!
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
        
        manageArticlesTable.dataSource = self
        manageArticlesTable.delegate = self
    }

    private func fetchArticles() {
        Task {
            do {
                self.articles = try await ResourceManager.share.fetchArticles()
                DispatchQueue.main.async {
                    self.manageArticlesTable.reloadData()
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

extension ManageArticlesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageArticleCell", for: indexPath) as! ManageArticlesTableViewCell


        cell.update(with: articles[indexPath.row])
        cell.showsReorderControl = true

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]

        if let articleDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController {
            articleDetailsVC.article = selectedArticle
            navigationController?.pushViewController(articleDetailsVC, animated: true)
        }
    }
}

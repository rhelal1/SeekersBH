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
    var allArticles: [Article] = []
    var isShowingHidden = false

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
        
        manageArticlesTable.dataSource = self
        manageArticlesTable.delegate = self
    }
    
    private func fetchArticles() {
        Task {
               do {
                   let fetchedArticles = try await AdminResourceManager.share.fetchArticles()
                   DispatchQueue.main.async {
                       self.allArticles = fetchedArticles
                       self.updateVisibleArticles()
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
    
    @IBOutlet weak var toggleArticlesButton: UIButton!
    @IBAction func didTapToggleArticles(_ sender: Any) {
        isShowingHidden.toggle()
           toggleArticlesButton.setTitle(isShowingHidden ? "Hide Hidden" : "Show Hidden", for: .normal)
           updateVisibleArticles()
    }
    
    func updateVisibleArticles() {
        if isShowingHidden {
            articles = allArticles.filter { $0.isHidden }
        } else {
            articles = allArticles.filter { !$0.isHidden }
        }
        manageArticlesTable.reloadData()
    }
    
    func updateArticleVisibility(articleID: String, isHidden: Bool) {
        if let index = allArticles.firstIndex(where: { $0.id == articleID }) {
            allArticles[index].isHidden = isHidden
        }
        updateVisibleArticles()
    }
}

extension ManageArticlesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageArticleCell", for: indexPath) as! ManageArticlesTableViewCell


        cell.update(with: articles[indexPath.row])
        
        cell.toggleVisibilityAction = { [weak self] articleID, isHidden in
                    guard let self = self else { return }
                    
                    // Update Firebase
                    FirebaseManager.shared.updateDocument(
                        collectionName: "Article",
                        documentId: articleID,
                        data: ["isHidden": isHidden]
                    ) { error in
                        if let error = error {
                            print("Failed to update visibility: \(error.localizedDescription)")
                        } else {
                            self.updateArticleVisibility(articleID: articleID, isHidden: isHidden)
                        }
                    }
                }
                return cell
        }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

//
//  AddArticleViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 20/12/2024.
//

import UIKit

class AddArticleViewController: UIViewController {
    
    @IBOutlet weak var articleTitle: UITextField!
    
    @IBOutlet weak var articleAuthor: UITextField!
    
    @IBOutlet weak var articleYOP: UITextField!
    
    @IBOutlet weak var articlePublisher: UITextField!
    
    @IBOutlet weak var articleDescription: UITextField!
    
    @IBOutlet weak var articleURL: UITextField!
    
    
    @IBOutlet weak var articleDOI: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func saveArticle(_ sender: Any) {
        guard let title = articleTitle.text, !title.isEmpty,
                      let author = articleAuthor.text, !author.isEmpty,
                      let yop = articleYOP.text, !yop.isEmpty,
                      let publisher = articlePublisher.text, !publisher.isEmpty,
                      let description = articleDescription.text, !description.isEmpty,
                      let url = articleURL.text, !url.isEmpty,
                      let doi = articleDOI.text, !doi.isEmpty else {
                    print("Please fill out all fields.")
                    return
                }
        
        let documentReference = FirebaseManager.shared.db.collection("Article").document()
           let documentID = documentReference.documentID
        
        let articleData: [String: Any] = [
                    "id":documentID,
                    "title": title,
                    "author": author,
                    "year_of_publication": Int(yop) ?? 0, // Convert year to Int
                   "publisher": publisher,
                   "description": description,
                   "url": url,
                   "DOI": doi,
                   "views": 0 // will always start with 0 views
               ]
        
        FirebaseManager.shared.addDocumentToCollection(collectionName: "Article", data: articleData)
    }
}

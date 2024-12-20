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
    
    @IBOutlet weak var articleCover: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

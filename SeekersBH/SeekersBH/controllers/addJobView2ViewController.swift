//
//  addJobView2ViewController.swift
//  SeekersBH
//
//  Created by Guest User on 12/12/2024.
//

import UIKit

class addJobView2ViewController: UIViewController {

    @IBOutlet weak var textview2: UITextView!
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var viewv: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textview1.layer.cornerRadius = 10
        textview2.layer.cornerRadius = 10
        viewv.layer.cornerRadius = 10
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

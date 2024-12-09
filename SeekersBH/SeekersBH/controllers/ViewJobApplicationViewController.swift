//
//  ViewJobApplicationViewController.swift
//  SeekersBH
//
//  Created by BP-36-201-18 on 09/12/2024.
//

import UIKit

class ViewJobApplicationViewController: UIViewController {
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view1.layer.cornerRadius = 25
        view2.layer.cornerRadius = 25
        view3.layer.cornerRadius = 25
        
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

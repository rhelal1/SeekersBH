//
//  CVDoneViewController.swift
//  SeekersBH
//
//  Created by marwa on 28/12/2024.
//

import UIKit

class CVDoneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

//
//  generalInformationCollectionViewCell.swift
//  SeekersBH
//
//  Created by BP-36-224-11 on 19/12/2024.
//

import UIKit

class generalInformationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Locationlbl: UILabel!
    @IBOutlet weak var Typelbl: UILabel!
    @IBOutlet weak var salarylbl: UILabel!
    @IBOutlet weak var deadlinelbl: UILabel!
    
    
    func setupCell(Location:String,Type:String,salary:String,Deadline:Date){
        Locationlbl.text = "Location: \(Location)"
        Typelbl.text = "Employment Type: \(Type)"
        salarylbl.text = "Salary: \(salary)"
        deadlinelbl.text = "Application Deadline: \(Deadline)"
            
    }
}

//
//  CVTableViewCell.swift
//  SeekersBH
//
//  Created by marwa on 20/12/2024.
//

import UIKit

class CVTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cvName: UILabel!
    @IBOutlet weak var cvDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

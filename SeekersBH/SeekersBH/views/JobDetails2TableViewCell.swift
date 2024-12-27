//
//  JobDetails2TableViewCell.swift
//  SeekersBH
//
//  Created by BP-36-224-10 on 27/12/2024.
//

import UIKit

class JobDetails2TableViewCell: UITableViewCell {

    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupCell() {
        // Configure cell appearance
        backgroundColor = .tertiarySystemGroupedBackground
        
        // Configure content label
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 17)
        contentLabel.textColor = .label
    }

}

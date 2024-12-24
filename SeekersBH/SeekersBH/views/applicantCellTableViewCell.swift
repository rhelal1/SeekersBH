//
//  applicantCellTableViewCell.swift
//  SeekersBH
//
//  Created by BP-36-224-10 on 25/12/2024.
//

import UIKit

class applicantCellTableViewCell: UITableViewCell {

    @IBOutlet weak var applicantName: UILabel!
    @IBOutlet weak var workexperence: UILabel!
    @IBOutlet weak var Appstatus: UILabel!
    @IBOutlet weak var appDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  jobCellTableViewCell.swift
//  SeekersBH
//
//  Created by Guest User on 15/12/2024.
//

import UIKit

class jobCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobType:UILabel!
    @IBOutlet weak var jobNamelbl: UILabel!
    @IBOutlet weak var datePosted: UILabel!
    @IBOutlet weak var numberOfApplication:UILabel!
    
    
    @IBAction func showDetailsBtn(_ sender: UIButton){
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupCell(jobName : String, date : Date, Type : String, numOfApplications : Int){
        jobNamelbl.text = jobName
        datePosted.text = "\(date)"
        jobType.text = Type
        numberOfApplication.text = "\(numOfApplications)"
    }

}

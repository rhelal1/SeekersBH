//
//  jobCellTableViewCell.swift
//  SeekersBH
//
//  Created by Guest User on 15/12/2024.
//

import UIKit

class jobCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobStatusLbl: UILabel!
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
    
    
    func setupCell(jobName: String, date: Date, Status: Status, numOfApplications: Int) {
        jobNamelbl.text = jobName
        
        // Format the date to a readable string
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let formattedDate = dateFormatter.string(from: date)
        
        datePosted.text = "Posted On \(formattedDate)"
        
        // Convert Status enum to a string
        let statusText = (Status == .Open) ? "Open" : "Closed"
        jobStatusLbl.text = "Status: \(statusText)"
        
        numberOfApplication.text = "Number Of Applications: \(numOfApplications)"
    }


}

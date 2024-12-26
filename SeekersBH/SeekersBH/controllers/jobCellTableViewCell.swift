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
    @IBOutlet weak var numberOfApplication: UILabel!
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var statusIndicator: UIView! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardView()
        setupStatusIndicator()
    }
    
    private func setupCardView() {
        cardContainer.layer.cornerRadius = 12
        cardContainer.layer.shadowColor = UIColor.black.cgColor
        cardContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardContainer.layer.shadowRadius = 4
        cardContainer.layer.shadowOpacity = 0.1
    }
    
    private func setupStatusIndicator() {
        statusIndicator.layer.cornerRadius = statusIndicator.frame.height / 2
        statusIndicator.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(jobName: String, date: Date, Status: JobStatus, numOfApplications: Int) {
        jobNamelbl.text = jobName
        
        // Format the date to a readable string
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let formattedDate = dateFormatter.string(from: date)
        
        datePosted.text = "Posted On \(formattedDate)"
        
        // Convert Status enum to a string and set indicator color
        let statusText = (Status == .Open) ? "Open" : "Closed"
        jobStatusLbl.text = "Status: \(statusText)"
        
        // Set status indicator color
        statusIndicator.backgroundColor = (Status == .Open) ? .systemGreen : .systemRed
        
        numberOfApplication.text = "Number Of Applications: \(numOfApplications)"
    }
}

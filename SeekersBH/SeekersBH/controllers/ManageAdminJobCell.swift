//
//  ManageAdminJobCell.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//


import UIKit

class AdminJobCell: UITableViewCell {
    
    
    @IBOutlet weak var jobNameLabel: UILabel!
    
    @IBOutlet weak var jobLocationLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    

    @IBOutlet weak var darePostedLabel: UILabel!
    
    
    @IBOutlet weak var statusLabel: UILabel!
        
    var isJobHidden =  false
    var documentId: String?
    
    func setupCell(jobName: String, jobLocation: String, date: Date, status: JobStatus, isHidden: Bool, documentId: String) {
        jobNameLabel.text = jobName
           jobLocationLabel.text = jobLocation
        statusLabel.text = (status == .Open) ? "Open" : "Closed"
        statusLabel.textColor = (status == .Open) ? .systemGreen : .systemRed
           isJobHidden = isHidden
           self.documentId = documentId
        let dateFormatter = DateFormatter()
          dateFormatter.dateStyle = .medium 
          dateFormatter.timeStyle = .none
          darePostedLabel.text = "Posted on \(dateFormatter.string(from: date))"
           actionButton.setTitle(
               isJobHidden ? "Unhide" : "Hide",
               for: .normal
           )
     }
    
    
    @IBAction func didTapAction(_ sender: Any) {
        guard  let documentId = documentId else { return }

           let newHiddenState = !isJobHidden

           FirebaseManager.shared.updateDocument(
               collectionName: "jobs",
               documentId: documentId,
               data: ["isHidden": newHiddenState]
           ) { error in
               if let error = error {
                   print("Failed to update isHidden: \(error.localizedDescription)")
               } else {
//                   print("isHidden updated successfully.")

                   DispatchQueue.main.async {
                       self.isJobHidden = newHiddenState
                       self.actionButton.setTitle(
                           newHiddenState ? "Unhide" : "Hide",
                           for: .normal
                       )

                       if let parentViewController = self.parentViewController as? ManageJobsViewController {
                           parentViewController.updateJobVisibility(documentId: documentId, isHidden: newHiddenState)
                       }
                   }
               }
           }
    }


}

//
//  ManageAdminJobCell.swift
//  SeekersBH
//
//  Created by Zainab Madan on 27/12/2024.
//


import UIKit


protocol ManageAdminJobCell: AnyObject {
    func didTapDelete(at indexPath: IndexPath)
}

class AdminJobCell: UITableViewCell {
    
    
    @IBOutlet weak var jobNameLabel: UILabel!
    
    @IBOutlet weak var jobLocationLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
//    @IBOutlet weak var datePostedLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
        
    var isJobHidden =  false
    var indexPath: IndexPath?
    var documentId: String?
    
    func setupCell(jobName: String, jobLocation: String, date: Date, status: JobStatus, isHidden: Bool, documentId: String) {
        jobNameLabel.text = jobName
           jobLocationLabel.text = jobLocation
//           statusLabel.text = status.rawValue
           statusLabel.textColor = (status == .Open) ? .systemGreen : .systemRed
           isJobHidden = isHidden
           self.documentId = documentId
           
           actionButton.setTitle(
               isJobHidden ? "Unhide" : "Hide",
               for: .normal
           )
     }
    
    
    @IBAction func didTapAction(_ sender: Any) {
        guard let indexPath = indexPath, let documentId = documentId else { return }

           let newHiddenState = !isJobHidden

           FirebaseManager.shared.updateDocument(
               collectionName: "jobs",
               documentId: documentId,
               data: ["isHidden": newHiddenState]
           ) { error in
               if let error = error {
                   print("Failed to update isHidden: \(error.localizedDescription)")
               } else {
                   print("isHidden updated successfully.")

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

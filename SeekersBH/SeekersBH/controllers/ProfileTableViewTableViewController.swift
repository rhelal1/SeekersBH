//
//  ProfileTableViewTableViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 30/12/2024.
//

import UIKit

class ProfileTableViewTableViewController: UITableViewController {
    
    @IBOutlet weak var intersts: UITableViewCell!
    
    @IBOutlet weak var skills: UITableViewCell!
    
    var userID = ""
    
           var skillsARR: [String] = []
           var interestsARR: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        userID = openedUserID
        fetchSkillsAndInterests()
       
    }
    
    func fetchSkillsAndInterests() {
           // Fetch skills
           UserManger.shared.fetchUserSkills(userID: userID) { [weak self] skills, error in
               guard let self = self, error == nil else { return }
               DispatchQueue.main.async {
                   self.skillsARR = skills
                   self.updateCellsContent()
               }
           }

           // Fetch interests
        UserManger.shared.fetchUserInterests(userID: userID) { [weak self] interests, error in
               guard let self = self, error == nil else { return }
               DispatchQueue.main.async {
                   self.interestsARR = interests
                   self.updateCellsContent()
               }
           }
       }

    func updateCellsContent() {
        skills.textLabel?.numberOfLines = 0 //for multi-line
        skills.textLabel?.text = skillsARR.isEmpty ? "None" : skillsARR.joined(separator: "\n")
        
        let formattedInterests = interestsARR.map { $0.replacingOccurrences(of: "\n", with: " ") }
        
        intersts.textLabel?.numberOfLines = 0 //for multi-line
        intersts.textLabel?.text = formattedInterests.isEmpty ? "None" : formattedInterests.joined(separator: "\n")
    }



}

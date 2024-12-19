//
//  jobDetailsViewController.swift
//  SeekersBH
//
//  Created by BP-36-224-11 on 19/12/2024.
//

import UIKit

class jobDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let jobs = JobManager.shared.jobs
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var jobDetailsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobDetailsCollectionView.delegate = self
        jobDetailsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generalInformationCell" , for: indexPath) as! generalInformationCollectionViewCell
        
        let job = jobs[indexPath.row]
        
        cell.setupCell(Location: <#T##String#>, Type: <#T##String#>, salary: <#T##String#>, Deadline: <#T##Date#>)
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

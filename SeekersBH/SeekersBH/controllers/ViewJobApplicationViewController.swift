//
//  ViewJobApplicationViewController.swift
//  SeekersBH
//
//  Created by BP-36-201-18 on 09/12/2024.
//

import UIKit

class ViewJobApplicationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let jobs = JobManager.shared.jobs
    @IBOutlet weak var jobsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jobsTableView.reloadData() // Ensure the table updates when the view is shown
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jobsTableView.dequeueReusableCell(withIdentifier: "jobPostCell") as! jobCellTableViewCell
        
        // Access the job for the current row
            let job = jobs[indexPath.row]
        
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

//
//  MangeVideosViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//

import UIKit

class MangeVideosViewController: UIViewController {
    
    @IBOutlet weak var videoTableview: UITableView!
    
    var videos: [Video] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            fetchVideos()
            
            videoTableview.dataSource = self
            videoTableview.delegate = self
        }


        private func fetchVideos() {
            Task {
                do {
                    self.videos = try await ResourceManager.share.fetchVideos()
                    DispatchQueue.main.async {
                        self.videoTableview.reloadData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showError(error)
                    }
                }
            }
        }

        private func showError(_ error: Error) {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }

        // Optionally, add action methods to add/edit/remove videos
    }

    extension MangeVideosViewController: UITableViewDataSource, UITableViewDelegate {

       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return videos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "adminVideoCell", for: indexPath) as! MangeVideosTableViewCell
            

            cell.update(with: videos[indexPath.row])

            return cell
        }


        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 400
        }

}

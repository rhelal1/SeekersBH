//
//  MangeVideosViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//


import UIKit

class MangeVideosViewController: UIViewController {
    
    @IBOutlet weak var videoTableview: UITableView!
    
    @IBOutlet weak var toggleVideosButton: UIButton!
    
    var videos: [Video] = []
    var allVideos: [Video] = []
    var isShowingHidden = false

    
        override func viewDidLoad() {
            super.viewDidLoad()
            fetchVideos()
            
            videoTableview.dataSource = self
            videoTableview.delegate = self
        }


        private func fetchVideos() {
            Task {
                do {
                    self.videos = try await AdminResourceManager.share.fetchVideos()
                    DispatchQueue.main.async {
                        self.allVideos = self.videos
                        self.updateVisibleVideos()
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
    
    
    @IBAction func didTapToggleVideos(_ sender: Any) {
        isShowingHidden.toggle()
                toggleVideosButton.setTitle(isShowingHidden ? "Hide Hidden" : "Show Hidden", for: .normal)
                updateVisibleVideos()
    }
    
    func updateVisibleVideos() {
        if isShowingHidden {
            videos = allVideos.filter { $0.isHidden }
        } else {
            videos = allVideos.filter { !$0.isHidden }
        }
        videoTableview.reloadData()
    }
    
    func updateVideoVisibility(videoID: String, isHidden: Bool) {
            if let index = allVideos.firstIndex(where: { $0.id == videoID }) {
                allVideos[index].isHidden = isHidden
            }
            updateVisibleVideos()
        }
    }

    extension MangeVideosViewController: UITableViewDataSource, UITableViewDelegate {

       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return videos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "adminVideoCell", for: indexPath) as! MangeVideosTableViewCell
            

            let video = videos[indexPath.row]
            cell.update(with: video)
            
            cell.toggleVisibilityAction = { [weak self] videoID, isHidden in
                       guard let self = self else { return }
                       
                       FirebaseManager.shared.updateDocument(
                           collectionName: "Videos",
                           documentId: videoID,
                           data: ["isHidden": isHidden]
                       ) { error in
                           if let error = error {
                               print("Failed to update visibility: \(error.localizedDescription)")
                           } else {
                               self.updateVideoVisibility(videoID: videoID, isHidden: isHidden)
                           }
                       }
                   }
                   
                   return cell
               }
               

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }


}

import UIKit

class VideosViewController: UIViewController {

    @IBOutlet weak var videosTable: UITableView!
    
    var videos: [Video] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        
        videosTable.dataSource = self
        videosTable.delegate = self
    }
    
    private func fetchVideos() {
        Task {
            do {
                self.videos = try await ResourceManager.share.fetchVideos()
                DispatchQueue.main.async {
                    self.videosTable.reloadData()
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

}

extension VideosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideosTableViewCell

        cell.update(with: videos[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Optional: remove separator lines (if not needed)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideo = videos[indexPath.row]

        // Instantiate the ArticleDetailsViewController
        if let videoDetailsVC = storyboard?.instantiateViewController(withIdentifier: "VideoDetailsViewController") as? VideoDetailsViewController {
            // Pass the selected article to the ArticleDetailsViewController
            videoDetailsVC.video = selectedVideo

            // Push the detail view controller
            navigationController?.pushViewController(videoDetailsVC, animated: true)
        }
    }
}

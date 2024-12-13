import UIKit

class SavedViewController: UIViewController {

    @IBOutlet weak var savedTable: UITableView!
    
    var saved: [SavedResource] = [
        SavedResource ( resource: Article(
            title: "Swift Programming",
            author: "John Doe",
            yearOfPublication: 2023,
            publisher: "TechPress",
            DOI: "12345",
            description: "An in-depth guide to Swift programming.",
            shortDescription: "A guide to Swift.",
            url: "https://example.com/swift",
            views: 1000
        ), type : .article),
        
        SavedResource ( resource: Webinar(
            title: "Swift in Practice",
            speaker: "Jane Smith",
            date: Date(),
            timeZone: TimeZone.current,
            picture: "webinar-image.png",
            description: "A webinar on Swift best practices.",
            url: "https://example.com/webinar",
            views: 500
        ), type : .webinar),

        SavedResource ( resource: Video(
            title: "Learn Swift in 30 Minutes",
            speaker: "Mark Lee",
            channel: "SwiftTutorials",
            duration: 1800,
            picture: "video-image.png",
            description: "A short video to learn Swift quickly.",
            url: "https://example.com/video",
            views: 3000
        ), type : .video)
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        savedTable.dataSource = self
        savedTable.delegate = self
    }
    

}

extension SavedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saved.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedTableViewCell
        
        // Set up the delete button closure
        cell.onDeleteTapped = {
            self.deleteResource(at: indexPath)
        }
        
        // Handle "View" action based on the type of the resource
        cell.onViewTapped = {
            self.viewResource(self.saved[indexPath.row])
        }
        
        cell.update(with: saved[indexPath.row])
        cell.showsReorderControl = true
        
        return cell
    }
    
    // Method to handle the delete action
    func deleteResource(at indexPath: IndexPath) {
        // Remove the resource from the data source array
        saved.remove(at: indexPath.row)
        
        // Delete the row from the table view with animation
        savedTable.deleteRows(at: [indexPath], with: .automatic)
    }

    // Method to view the resource based on its type
    func viewResource(_ savedResource: SavedResource) {
        
        if let article = savedResource.resource as? Article {
            
            if let articleDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController {
                // Pass the selected article to the ArticleDetailsViewController
                articleDetailsVC.article = article
                
                // Push the detail view controller
                navigationController?.pushViewController(articleDetailsVC, animated: true)
                
            } else if let webinar = savedResource.resource as? Webinar {

                if let webinarDetailsVC = storyboard?.instantiateViewController(withIdentifier: "WebinarDetailsViewController") as? WebinarDetailsViewController {
                    // Pass the selected article to the ArticleDetailsViewController
                    webinarDetailsVC.webinar = webinar
                    
                    // Push the detail view controller
                    navigationController?.pushViewController(webinarDetailsVC, animated: true)
                    
                } else if let video = savedResource.resource as? Video {

                    if let videoDetailsVC = storyboard?.instantiateViewController(withIdentifier: "VideoDetailsViewController") as? VideoDetailsViewController {
                        // Pass the selected article to the ArticleDetailsViewController
                        videoDetailsVC.video = video
                        
                        // Push the detail view controller
                        navigationController?.pushViewController(videoDetailsVC, animated: true)
                        
                    }
                }
                
                func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                    // Optional: remove separator lines (if not needed)
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                    cell.preservesSuperviewLayoutMargins = false
                }
                
                func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    return 200
                }
                
                //    // UITableViewDelegate method
                //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                //        let selectedVide = saved[indexPath.row]
                //
                //        // Instantiate the ArticleDetailsViewController
                //        if let videoDetailsVC = storyboard?.instantiateViewController(withIdentifier: "VideoDetailsViewController") as? VideoDetailsViewController {
                //            // Pass the selected article to the ArticleDetailsViewController
                //            videoDetailsVC.video = selectedVideo
                //
                //            // Push the detail view controller
                //            navigationController?.pushViewController(videoDetailsVC, animated: true)
                //        }
                //    }
            }
        }
    }
}

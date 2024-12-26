import UIKit

class SavedViewController: UIViewController {

    @IBOutlet weak var savedTable: UITableView!
    
    var saved: [Resource] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSaved()

        savedTable.dataSource = self
        savedTable.delegate = self
    }
    
    private func fetchSaved() {
        Task {
            do {
                self.saved = try await ResourceManager.share.fetchAllResourcesForUser(userID: AccessManager.userID!)
                DispatchQueue.main.async {
                    self.savedTable.reloadData()
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
        
        // Create the alert controller
            let alertController = UIAlertController(
                title: "Confirm Deletion",
                message: "Are you sure you want to delete this resource?",
                preferredStyle: .alert
            )
        
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            // Call the deletion function if user confirms
            let selectedResource = self.saved[indexPath.row]
            var typeSaved : ResourceTypes = .article
            
            
            // Check the type of the resource using `type(of:)`
            switch type(of: selectedResource) {
            case is Article.Type:
                typeSaved = .article
                
            case is Webinar.Type:
                typeSaved = .webinar
                
            case is Video.Type:
                typeSaved = .video
                
            default:
                print("Unknown resource type")
            }
            
            
            Task {
                do {
                    try await ResourceManager.share.RemoveResourceFromUser(userID: AccessManager.userID!, resourceType: typeSaved
                                                                           , resourceID: self.saved[indexPath.row].id)
                    
                    // Show success alert
                    self.showAlert(title: "Success", message: "Resource removed successfully.", viewController: self)
                    
                    self.fetchSaved()
                    
                } catch {
                    // Show error alert
                    self.showAlert(title: "Error", message: "Failed to remove resource: \(error.localizedDescription)", viewController: self)
                }
            }
        }
        
        // Add "Cancel" action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            // Add actions to the alert controller
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            // Present the alert controller
            self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }

    // Method to view the resource based on its type
    func viewResource(_ savedResource: Resource) {
        
        if let article = savedResource as? Article {
            
            if let articleDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController {
                // Pass the selected article to the ArticleDetailsViewController
                articleDetailsVC.article = article
                
                // Push the detail view controller
                navigationController?.pushViewController(articleDetailsVC, animated: true)
            }
            } else if let webinar = savedResource as? Webinar {

                if let webinarDetailsVC = storyboard?.instantiateViewController(withIdentifier: "WebinarDetailsViewController") as? WebinarDetailsViewController {
                    // Pass the selected webinar to the WebinarDetailsViewController
                    webinarDetailsVC.webinar = webinar
                    
                    // Push the detail view controller
                    navigationController?.pushViewController(webinarDetailsVC, animated: true)
                }
                } else if let video = savedResource as? Video {

                    if let videoDetailsVC = storyboard?.instantiateViewController(withIdentifier: "VideoDetailsViewController") as? VideoDetailsViewController {
                        // Pass the selected video to the VideoDetailsViewController
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

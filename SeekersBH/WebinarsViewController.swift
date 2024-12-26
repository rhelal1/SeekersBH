import UIKit

class WebinarsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var webinars: [Webinar] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWebinars();
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchWebinars() {
        Task {
            do {
                self.webinars = try await ResourceManager.share.fetchWebinars()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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

extension WebinarsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webinars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "webinarCell", for: indexPath) as! WebinarsTableViewCell

        cell.update(with: webinars[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Optional: remove separator lines (if not needed)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
     //UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWebinar = webinars[indexPath.row]

        // Instantiate the ArticleDetailsViewController
        if let webinarDetailsVC = storyboard?.instantiateViewController(withIdentifier: "WebinarDetailsViewController") as? WebinarDetailsViewController {
            // Pass the selected article to the ArticleDetailsViewController
            webinarDetailsVC.webinar = selectedWebinar

            // Push the detail view controller
            navigationController?.pushViewController(webinarDetailsVC, animated: true)
        }
    }
}

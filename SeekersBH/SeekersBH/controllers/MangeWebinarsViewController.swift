//
//  MangeWebinarsViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//

import UIKit


class MangeWebinarsViewController: UIViewController {
    
    @IBOutlet weak var toggleWebinarsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var webinars: [Webinar] = []
    var allWebinars: [Webinar] = []
    var isShowingHidden = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWebinars()

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func fetchWebinars() {
        Task {
            do {
                self.webinars = try await AdminResourceManager.share.fetchWebinars()
                DispatchQueue.main.async {
                    self.allWebinars = self.webinars
                    self.updateVisibleWebinars()
                }
            } catch {
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
        }
        
        
        
    }

    @IBAction func didTapToggleWebinars(_ sender: Any) {
        isShowingHidden.toggle()
               toggleWebinarsButton.setTitle(isShowingHidden ? "Hide Hidden" : "Show Hidden", for: .normal)
               updateVisibleWebinars()
    }
    
    func updateVisibleWebinars() {
        if isShowingHidden {
            webinars = allWebinars.filter { $0.isHidden }
        } else {
            webinars = allWebinars.filter { !$0.isHidden }
        }
        tableView.reloadData()
    }
    
    func updateWebinarVisibility(webinarID: String, isHidden: Bool) {
        if let index = allWebinars.firstIndex(where: { $0.id == webinarID }) {
            allWebinars[index].isHidden = isHidden
        }
        updateVisibleWebinars()
    }
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension MangeWebinarsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webinars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminWebinarCell", for: indexPath) as! MangeWebinarsTableViewCell

        let webinar = webinars[indexPath.row]
        cell.update(with: webinar)
        
        cell.toggleVisibilityAction = { [weak self] webinarID, isHidden in
            guard let self = self else { return }
            
            FirebaseManager.shared.updateDocument(
                collectionName: "Webinars",
                documentId: webinarID,
                data: ["isHidden": isHidden]
            ) { error in
                if let error = error {
                    print("Failed to update visibility: \(error.localizedDescription)")
                } else {
                    self.updateWebinarVisibility(webinarID: webinarID, isHidden: isHidden)
                }
            }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWebinar = webinars[indexPath.row]

        if let webinarDetailsVC = storyboard?.instantiateViewController(withIdentifier: "WebinarDetailsViewController") as? WebinarDetailsViewController {
            webinarDetailsVC.webinar = selectedWebinar
            navigationController?.pushViewController(webinarDetailsVC, animated: true)
        }
    }
}

//
//  MangeWebinarsViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 26/12/2024.
//

import UIKit


class MangeWebinarsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var webinars: [Webinar] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWebinars()

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

// MARK: - UITableViewDataSource & UITableViewDelegate
extension MangeWebinarsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webinars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminWebinarCell", for: indexPath) as! MangeWebinarsTableViewCell

        cell.update(with: webinars[indexPath.row])

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

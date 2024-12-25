import UIKit
import FirebaseFirestore

class IInterest: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var donebtn: UIButton!
    
    // Array to track selected cells (limit to max 4 selections)
    var selectedIndexPaths: [IndexPath] = []
    
    // Array to store the user's selected interests
    var selectedInterests: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Attach action to the Done button
        donebtn.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    @objc func doneButtonTapped() {
        // Save the selected interests
        saveSelectedInterests()
    }
    
    func saveSelectedInterests() {
        guard let userId = getUserId() else {
            showAlert(message: "User ID not found. Please log in again.")
            return
        }
        
        // Debugging print statements
        print("Saving interests for user ID: \(userId)")
        print("Selected interests: \(selectedInterests)")
        
        // Reference to Firestore
        let db = Firestore.firestore()
        
        // Update the user's interests in Firestore
        db.collection("User").document(userId).updateData(["interests": selectedInterests]) { error in
            if let error = error {
                print("Error saving interests: \(error.localizedDescription)")
                self.showAlert(message: "Error saving interests: \(error.localizedDescription)")
            } else {
                print("Interests saved successfully!")
                self.showAlert(message: "Your interests have been saved successfully!", title: "Success")
            }
        }
    }
    
    func getUserId() -> String? {
        // Replace this with logic to fetch the current user's ID (e.g., from Firebase Auth)
        // Mock user ID for testing
        return "mock_user_id" // Replace with a valid document ID from Firestore
    }
    
    func showAlert(message: String, title: String = "Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension IInterest: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return intrest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.setup(with: intrest[indexPath.row])
        
        // Check if the current indexPath is selected
        if selectedIndexPaths.contains(indexPath) {
            cell.contentView.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1) // #D9D9D9
        } else {
            cell.contentView.backgroundColor = .white // Default color
        }
        
        return cell
    }
}

extension IInterest: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let itemsPerRow: CGFloat = 2
        let totalPadding = padding * (itemsPerRow - 1)
        let width = (collectionView.frame.width - totalPadding) / itemsPerRow
        let height: CGFloat = 75
        
        return CGSize(width: width, height: height)
    }
}

extension IInterest {
    // Handle item selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedInterestTitle = intrest[indexPath.row].title
        
        // If the cell is already selected, remove it from the selection
        if let index = selectedIndexPaths.firstIndex(of: indexPath) {
            selectedIndexPaths.remove(at: index)
            selectedInterests.removeAll { $0 == selectedInterestTitle } // Remove the title
        } else {
            // If the selection is under the max limit (4), add the indexPath
            if selectedIndexPaths.count < 4 {
                selectedIndexPaths.append(indexPath)
                selectedInterests.append(selectedInterestTitle) // Add the title
            } else {
                showAlert(message: "You can only select up to 4 interests.")
            }
        }
        
        // Reload the collection view to update the selected states
        collectionView.reloadData()
    }
}

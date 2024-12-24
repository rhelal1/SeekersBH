import UIKit

class IInterest: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Array to track selected cells (limit to max 4 selections)
    var selectedIndexPaths: [IndexPath] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
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
        // If the cell is already selected, remove it from the selection
        if let index = selectedIndexPaths.firstIndex(of: indexPath) {
            selectedIndexPaths.remove(at: index)
        } else {
            // If the selection is under the max limit (4), add the indexPath
            if selectedIndexPaths.count < 4 {
                selectedIndexPaths.append(indexPath)
            }
        }
        
        // Reload the collection view to update the selected states
        collectionView.reloadData()
    }
}

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(with intrest: Intrest) {
        titleLabel.text = intrest.title
        
        // Set border color and radius
        self.contentView.layer.borderColor = UIColor(red: 9/255, green: 24/255, blue: 86/255, alpha: 1).cgColor // Border color #091856
        self.contentView.layer.borderWidth = 2 // Set the border width
        
        // Set corner radius for rounded corners
        self.contentView.layer.cornerRadius = 10 // Set corner radius (adjust as needed)
        self.contentView.layer.masksToBounds = true // Make sure content stays inside the rounded corners
    }
}

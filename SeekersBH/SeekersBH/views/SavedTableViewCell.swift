import UIKit

class SavedTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var resourceTitle: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // Closure for actions
    var onViewTapped: (() -> Void)?
    var onDeleteTapped: (() -> Void)?
    
    @IBAction func viewButtonTapped(_ sender: Any) {
        // Call the view action closure when the button is tapped
        onViewTapped?()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        // Call the delete action closure when the button is tapped
        onDeleteTapped?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with savedRescource: Resource) {
        
        switch savedRescource {
        case let article as Article:
            resourceTitle.text = savedRescource.title + "(Article)"
        case let webinar as Webinar:
            resourceTitle.text = savedRescource.title + "(Webinar)"
        case let video as Video:
            resourceTitle.text = savedRescource.title + "(Video)"
        default:
            resourceTitle.text = "unknown"
        }

        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }

}

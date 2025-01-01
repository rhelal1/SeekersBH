import UIKit

class CertificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var certificateTitle: UILabel!
    @IBOutlet weak var certifDate: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with certification: CourseCertification) {
        certificateTitle.text = certification.title
        certifDate.text = certification.extractDateTimeString()
        scoreLabel.text = "\(certification.score)%"
        viewCell.layer.cornerRadius = 15
        viewCell.layer.masksToBounds = true
    }

}

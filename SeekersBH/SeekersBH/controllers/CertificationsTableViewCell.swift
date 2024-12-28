import UIKit

class CertificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var certificateTitle: UILabel!
    @IBOutlet weak var certifDate: UILabel!
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with certification: CourseCertification) {
        certificateTitle.text = certification.title
        certifDate.text = "\(certification.date)"
        viewCell.layer.cornerRadius = 15
        viewCell.layer.masksToBounds = true
    }

}

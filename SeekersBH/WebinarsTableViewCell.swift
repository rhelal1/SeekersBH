import UIKit

class WebinarsTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var imageW: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with webinar: Webinar) {
        // Load the image asynchronously
        if let imageUrl = URL(string: webinar.picture) {
                // Perform the network request asynchronously
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let error = error {
                        print("Error loading image: \(error.localizedDescription)")
                        return
                    }
                    
                    // Ensure data is available and it is valid
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            // Update the image view on the main thread
                            self.imageW.image = image
                        }
                    }
                }.resume()
            }
        title.text = webinar.title
        descriptions.text = webinar.description
    
        imageW.layer.cornerRadius = 15

        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }
}

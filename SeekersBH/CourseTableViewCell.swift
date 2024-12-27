import UIKit

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var imageW: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var starsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with course: Course) {
        // Load the image asynchronously
            if let imageUrl = URL(string: course.pictureUrl) {
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
        
        title.text = course.title

        imageW.layer.cornerRadius = 15
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
        // Set the rating stars
        updateStars(for: calculateAverageRating(comments: course.courseComments))
    }
    
    func calculateAverageRating(comments: [CourseComments]) -> Double {
        guard !comments.isEmpty else { return 0.0 } // Return 0 if the array is empty

        var totalRating = 0
        var ratingCount = 0

        // Loop over the comments to calculate the total rating and count
        for comment in comments {
            totalRating += comment.rated
            ratingCount += 1
        }

        // Calculate the average rating
        let averageRating = Double(totalRating) / Double(ratingCount)
        return averageRating
    }
    
    
    private func updateStars(for rating: Double) {
            let filledStars = Int(rating)          // Number of fully filled stars
            let hasHalfStar = rating - Double(filledStars) >= 0.5 // Check for half-filled star

            for (index, starView) in starsStackView.arrangedSubviews.enumerated() {
                if let starImage = starView as? UIImageView {
                    if index < filledStars {
                        starImage.image = UIImage(systemName: "star.fill")
                    } else if index == filledStars && hasHalfStar {
                        starImage.image = UIImage(systemName: "star.lefthalf.fill")
                    } else {
                        starImage.image = UIImage(systemName: "star")
                    }
                }
            }
        }
}

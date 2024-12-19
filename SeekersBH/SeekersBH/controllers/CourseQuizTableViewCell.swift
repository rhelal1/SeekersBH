import UIKit

protocol AnswerSelectionDelegate: AnyObject {
    func didSelectAnswer(for questionIndex: Int, optionIndex: Int)
}

class CourseQuizTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var question: UILabel!

    @IBOutlet var optionButtons: [UIButton]!
    
    

    weak var delegate: AnswerSelectionDelegate?
    var questionIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with question: Question, at index: Int, delegate: AnswerSelectionDelegate) {
        self.delegate = delegate
        self.questionIndex = index

        self.question.text = question.questionTxt
        
        // Set option titles and update selection
        for (i, button) in optionButtons.enumerated() {
            button.setTitle(question.options[i], for: .normal)
            button.isSelected = (question.selectedAnswer == i)
            button.backgroundColor = button.isSelected ? UIColor(hex : "#D9D9D9") : .clear
            button.layer.cornerRadius = 15
        }

        view.layer.borderWidth = 1.0 // Thickness
        view.layer.borderColor = UIColor(hex : "#D9D9D9")!.cgColor // Border color
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }

    
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        // Find the index of the button that was tapped within the optionButtons array
        if let index = optionButtons.firstIndex(of: sender) {
            // Inform the delegate that an answer was selected
            delegate?.didSelectAnswer(for: questionIndex, optionIndex: index)
        }
    }
    
}


extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        
        let length = hexSanitized.count
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgb & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        } else {
            return nil
        }
    }
}

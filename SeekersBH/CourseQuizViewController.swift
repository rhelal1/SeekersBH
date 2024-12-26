import UIKit

class CourseQuizViewController: UIViewController, AnswerSelectionDelegate {

    @IBOutlet weak var quizeTable: UITableView!
    var userAnswer : [Int: String] = [:]
    
    var quizeQuestions : [Question]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizeTable.delegate = self
        quizeTable.dataSource = self
        quizeTable.reloadData()
    }
    
    func didSelectAnswer(for questionIndex: Int, optionIndex: Int) {
        quizeQuestions[questionIndex].selectedAnswer = optionIndex
        quizeTable.reloadData()
    }
    
}

extension CourseQuizViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizeQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! CourseQuizTableViewCell

        cell.update(with: quizeQuestions[indexPath.row], at: indexPath.row, delegate: self)
        cell.showsReorderControl = true
                
        return cell
    }
    
    
//    // UITableViewDelegate method
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedUser = courseComments[indexPath.row]
//        print(selectedUser.username)
//    }
}

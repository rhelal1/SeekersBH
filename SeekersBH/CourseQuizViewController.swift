import UIKit

class CourseQuizViewController: UIViewController, AnswerSelectionDelegate {

    @IBOutlet weak var quizeTable: UITableView!
    
    var course : Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizeTable.delegate = self
        quizeTable.dataSource = self
        quizeTable.reloadData()
    }
    
    func didSelectAnswer(for questionIndex: Int, optionIndex: Int) {
        course.courseQuestions[questionIndex].selectedAnswer = optionIndex
        quizeTable.reloadData()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        // Calculate the score
               var score = 0
               var totalPoints = 0
               
               for var question in course.courseQuestions {
                   totalPoints += question.points
                   if question.selectedAnswer != -1 && question.options[question.selectedAnswer] == question.correctAnswer {
                       score += question.points
                   }
                   question.selectedAnswer = -1
               }
               
        // Determine if the user passed
        let passingScore = Int(Double(score) / Double(totalPoints) * 100)
               
        if passingScore >= 60 {
        
                // Navigate to PassQuizViewController
                if let passVC = storyboard?.instantiateViewController(withIdentifier: "PassQuizViewController") as? PassQuizViewController {
                    
                    passVC.score = passingScore
                    passVC.course = course
                    
                    passVC.modalPresentationStyle = .fullScreen // Prevent dismissal gesture
                    present(passVC, animated: true, completion: nil)
                    
                }
            } else {
                // Navigate to FailQuizViewController
                if let failVC = storyboard?.instantiateViewController(withIdentifier: "FailQuizViewController") as? FailQuizViewController {
                    failVC.score = score
                    failVC.course = course
                    failVC.modalPresentationStyle = .fullScreen // Prevent dismissal gesture
                    present(failVC, animated: true, completion: nil)
                }
            }
    }
}

extension CourseQuizViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course.courseQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! CourseQuizTableViewCell

        cell.update(with: course.courseQuestions[indexPath.row], at: indexPath.row, delegate: self)
        cell.showsReorderControl = true
                
        return cell
    }
}

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let myStoryBoard = UIStoryboard(name: "zainab", bundle: nil)
        
        let myVC = myStoryBoard.instantiateInitialViewController()!
        myVC.modalPresentationStyle = .fullScreen
        
        present(myVC, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let myStoryBoard = UIStoryboard(name: "marwa", bundle: nil)

        let myVC = myStoryBoard.instantiateInitialViewController()!
        myVC.modalPresentationStyle = .fullScreen

        present(myVC, animated: true)
    }

}

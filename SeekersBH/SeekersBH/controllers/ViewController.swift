import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MDN")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let myStoryBoard = UIStoryboard(name: "zainab", bundle: nil)
        
        let myVC = myStoryBoard.instantiateInitialViewController()!
        myVC.modalPresentationStyle = .fullScreen
        
        present(myVC, animated: true)
    }

}


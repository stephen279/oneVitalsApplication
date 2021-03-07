

import UIKit

class DisplayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 
    @IBAction func BackButton(_ sender: Any) {
        
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(newViewController, animated: true, completion: nil)
        
        
        
        
    }
    
}

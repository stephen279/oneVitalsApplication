//
//  NavigationViewController.swift
//  oneVitalsApplication
//
//  Created by stephen holland on 30/01/2021.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedIn(){
            print ("loggrd in from navigator")
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          //  print("1.33")
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.present(newViewController, animated: true, completion: nil)
        }else{
            
            print ("not loggred in from navigator")
          //  perform(#selector(ProfileViewController),with: nil)
       //     perform(#Selector(ProfileViewController.self),with:nil, afterDelay: 0.01 )
        }
        

        // Do any additional setup after loading the view.
    }
    

    fileprivate func isLoggedIn() -> Bool{
        
        return UserDefaults.standard.bool(forKey: "isloggedin")
    }

}

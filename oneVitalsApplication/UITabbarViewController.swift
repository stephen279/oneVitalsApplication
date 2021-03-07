//
//  UITabbarViewController.swift
//  oneVitalsApplication
//
//  Created by stephen holland on 01/02/2021.
//

import UIKit

class UITabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("UITABBAR OPENED")
        
        if isLoggedIn(){
            print ("loggrd in from UITABBAR")
            print("session is",UserDefaults.standard.bool(forKey: "isLoggedin"))
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          //  print("1.33")
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.present(newViewController, animated: true, completion: nil)
         //   newViewController.patient_idLabel?.text = "eeee"
        
           
        }else{
            
            print ("not loggred in from UITABBARbar")
          //  perform(#selector(ProfileViewController),with: nil)
       //     perform(#Selector(ProfileViewController.self),with:nil, afterDelay: 0.01 )
            
            
        }
        
      
    }
    
    
    
    fileprivate func isLoggedIn() -> Bool{
        
        return UserDefaults.standard.bool(forKey: "isLoggedin")
    }

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }

}

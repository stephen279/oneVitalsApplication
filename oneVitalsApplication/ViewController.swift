//
//  ViewController.swift
//  oneVitalsApplication
//
//  Created by stephen holland on 29/12/2020.
//

import UIKit
import Alamofire    
 
internal class ViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    public var  pat_id:String = ""
    
    public var pat_name:String = ""
    
    var nameText = ""
    
    var idText = ""
    
    public var id_session:String = ""
    
  
    
    
    //http://localhost/onevitals/Api_ci/login_api_ci?email=s@m.com&password=123
    var URL_USER_LOGIN = "http://www.onevitals.com/accounts/Api_ci/login_api_ci"
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldPassword.delegate = self
        // Do any additional setup after loading the view.
        
        if isLoggedIn(){
            print ("loggrd in from viewcontroller navigator")
            
            self.performSegue(withIdentifier: "pass_id", sender: self)
           
            

           
        }else{
            
            print ("not loggred in from viewcontroller navigator")
          //  perform(#selector(ProfileViewController),with: nil)
       //     perform(#Selector(ProfileViewController.self),with:nil, afterDelay: 0.01 )
            
        }
        
        
        
        
        
      
    }
    
 
    
    fileprivate func isLoggedIn() -> Bool{
        
        return UserDefaults.standard.bool(forKey: "isLoggedin")
    }

  
   

    func openUrl(urlStr:String!) {

         if let url = NSURL(string:urlStr) {
            UIApplication.shared.openURL(url as URL)
    }

       }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func buttonRegister(_ sender: UIButton) {
        openUrl(urlStr: "http:www.onevitals.com/accounts/login")
    }
    
    
    @IBAction func buttonLogin(_ sender: Any) {
        
       
        
        if (textFieldEmail.text == "" || textFieldPassword.text == ""){
            resultLabel.text = "Please enter email and password";
        }else{
            
            let parameters: Parameters = [
                 "email":textFieldEmail.text!,"password":textFieldPassword.text!
            ]
            
           
            //making a post request
            AF.request(URL_USER_LOGIN, method: .get, parameters: parameters).responseJSON
            {
                response in
                
              //  print(response)
                
                if let result = response.value{
                   // print("1")
                    let jsonData = result as! NSDictionary
                   // print(jsonData.value(forKey: "error"))s
                   // print("1.2")
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                
                       // loop through to get patient_id from arrayObject
                        if  let returned_user = jsonData.value(forKey: "user") as? [[String:Any]],
                           let patient = returned_user.first {
                            self.pat_id = patient["patient_id"] as! String
                            
                            self.pat_name = patient["name"] as! String
                            
                            
                            //   print(patient["patient_id"]) // the value is an optional.
                         
                            
                            
                            self.idText = self.pat_id
                            self.nameText = self.pat_name
                            
                            UserDefaults.standard.setValue( self.pat_name  , forKey: "f_name")
                            UserDefaults.standard.synchronize()
                            
                            UserDefaults.standard.setValue( self.pat_id  , forKey: "f_id")
                            UserDefaults.standard.synchronize()
                            
                            self.performSegue(withIdentifier: "pass_id", sender: self)
                        }
                        
                        UserDefaults.standard.setValue(true, forKey: "isLoggedin")
                        UserDefaults.standard.synchronize()
                        
                       
                        
                    
                        
                        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                      //  print("1.33")
                        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                        self.present(newViewController, animated: true, completion: nil)
                     //   newViewController.patient_idLabel?.text = "eeee"
                    
                       
                        
                        
                        
                    }else{
                        
                        self.resultLabel.text = "invalid email and password"
                    }
                }
                
                
            }
            
           // Alamofire.request(URL_USER_IN)
        }
        
      //  performSegue(withIdentifier: "pass_id", sender: self)
    }
    
  /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabVc = segue.destination as! UITabBarController
        let vc = tabVc. as! ProfileViewController
        vc.final_id = self.idText
        vc.final_name = self.nameText
    }*/
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabVC = segue.destination as? UITabBarController {
            if let navVC = tabVC.viewControllers!.first as? UINavigationController {
                if let nextVC =  navVC.viewControllers.first as? ProfileViewController {
                  //  nextVC.varName = "works like a charm"
                    nextVC.final_id = self.idText
                    nextVC.final_name = self.nameText
                }
            }
        }
    }
}


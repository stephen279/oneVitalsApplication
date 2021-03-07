//
//  ProfileViewController.swift
//  oneVitalsApplication
//
//  Created by stephen holland on 02/01/2021.
//
import UIKit
import WebKit
import Alamofire



class ProfileViewController:  UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet var patient_idLabel: UILabel!
    
    
    @IBOutlet var patient_nameLabel: UILabel!
    
    @IBOutlet var AppointmentOut: UITabBarItem!
   
    @IBOutlet weak var TableViewItem: UITableView!
    
    
    @IBOutlet var patientWeightCell: UILabel!
    
    @IBOutlet var appointmentLabel: UILabel!
    @IBOutlet var appointmenttimeLabel: UILabel!
    
    @IBOutlet var weightLabel: UILabel!
    
    @IBOutlet var weightDateLabel: UILabel!
    
    @IBOutlet var respirationLabel: UILabel!
    @IBOutlet var respirationDateLabel: UILabel!
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var temperatureDateLabel: UILabel!
    
    @IBOutlet var spo2DateLabel: UILabel!
    @IBOutlet var spo2Label: UILabel!
    
    @IBOutlet var heartLabel: UILabel!
    @IBOutlet var heartDateLabel: UILabel!
    
    @IBOutlet var diaDateLabel: UILabel!
    @IBOutlet var diaLabel: UILabel!
    
    @IBOutlet var sysLabel: UILabel!
    
    var webView: WKWebView!
    
    var final_id = ""
    
    var id_to_pass = ""
    
    var final_name = ""
    
    public var param_id:String = ""
    
  
    
    public var  pat_id:String = ""
    
    public var  par_id:String? = ""
    
    public var pat_weight:String = ""
    public var pat_date_weight:String = ""
    
    
    public var pat_temperature:String = ""
    public var pat_date_temperature:String = ""
    
    public var pat_respiraton:String = ""
    public var pat_date_respiration:String = ""
    
    public var pat_spo2:String = ""
    public var pat_date_spo2:String = ""
    
    public var pat_heart:String = ""
    public var pat_date_heart:String = ""
    
    public var pat_date_appointment:String = ""
    public var pat_date_starttime:String = ""
    
    
    public var pat_sys:String = ""
    public var pat_dia:String = ""
    public var pat_date_dia:String = ""
    
   
    public var pat_label:String = ""

    override func viewDidLoad(){
        
      
    
    super.viewDidLoad()
        print("sessiom",UserDefaults.standard.bool(forKey: "isLoggedin") )
        
        if (UserDefaults.standard.bool(forKey: "isLoggedin") == false){
            print ("loggr outfrom Profilecontroller")
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
           // self.performSegue(withIdentifier: "unwindToViewController", sender: self)
            
       
        }else{
            
            print (" loggred in from profilecontroller")
          //  perform(#selector(ProfileViewController),with: nil)
       //     perform(#Selector(ProfileViewController.self),with:nil, afterDelay: 0.01 )
        }
        
      
  
    

  
        
     
     //   var url = URL(string: "http://onevitals.com/accounts/Api_ci/weight_api_ci?patient_id=")
     //   url?.appendingPathExtension("patient_id", value: 29)
  
        
        
        // "https://example.com?abc=123&amp;lmn=tuv&amp;xyz=987&amp;def=456"
          ///     url?.appendingQueryItem("xyz", value: "999") // "https://example.com?abc=123&amp;lmn=tuv&amp;xyz=999"
          ///
        
    
       // let par_id = UserDefaults.standard.string(forKey: "f_id")
      //  print("loaded", par_id )
       // self.param_id = UserDefaults.standard.string(forKey: "f_id")!
        
        
        patient_idLabel.text = UserDefaults.standard.string(forKey: "f_id")
        patient_nameLabel.text = self.final_name
        
        self.tabBarController?.delegate = self
        
        
        
      //  let testLink = UserDefaults.standard.string(forKey: "f_id")
       // let mobileLink = UserDefaults.standard.string(forKey: "f_id")
     //   let url = URL(string: "http://onevitals.com/accounts/Api_ci/weight_api_ci?patient_id='\(par_id!)'")!
    
        
      //  print(url)
        
     
        
     
        
        if (self.final_id == ""){
            
            print ("self.final_id = nil")
            
           
            
          
        }
        
        if (  patient_nameLabel.text  == ""){
            
            print ("self.final_name = nil")
            
            
            
            patient_nameLabel.text = UserDefaults.standard.string(forKey: "f_name")
        }
        
        downloadJSON()
        
      
    }
    
    
    @IBAction func buttonLogout(_ sender: Any) {
        UserDefaults.standard.setValue(false, forKey: "isLoggedin")
        UserDefaults.standard.synchronize()
        
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
        
      
        
        
    }
    
    
 
 
    
    @IBAction func addHealthButton(_ sender: Any) {
        
        self.id_to_pass = patient_idLabel.text!
        performSegue(withIdentifier: "pass_id2", sender: self)
       
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! AddNewViewController
        vc.final_id = self.id_to_pass
    }
    
    
    func downloadJSON(){
   
    
       
        
         par_id = UserDefaults.standard.string(forKey: "f_id")
       // print(par_id)
        
        if par_id != nil {
           print("unwrapped")
        } else {
            
            par_id = "0001"
          
            
            
            
            
        }
        
        //define urls
        
        let url = URL(string: "http://onevitals.com/accounts/Api_ci/weight_api_ci?patient_id='\(par_id!)'")!
        let url_temperature = URL(string: "http://onevitals.com/accounts/Api_ci/temperature_api_ci?patient_id='\(par_id!)'")!
        let url_heart = URL(string: "http://onevitals.com/accounts/Api_ci/heart_api_ci?patient_id='\(par_id!)'")!
        let url_sys = URL(string: "http://onevitals.com/accounts/Api_ci/sys_api_ci?patient_id='\(par_id!)'")!
        let url_dia = URL(string: "http://onevitals.com/accounts/Api_ci/dia_api_ci?patient_id='\(par_id!)'")!
        let url_spo2 = URL(string: "http://onevitals.com/accounts/Api_ci/spo2_api_ci?patient_id='\(par_id!)'")!
        let url_resp = URL(string: "http://onevitals.com/accounts/Api_ci/resp_api_ci?patient_id='\(par_id!)'")!
        let url_appoint = URL(string: "http://onevitals.com/accounts/Api_ci/appoint_api_ci?patient_id='\(par_id!)'")!

        // print(url)
        //making a post request for weight
        AF.request(url, method:.get).responseJSON
        {
            response in
            
            print(response)
            
            if let result = response.value{
                print("1")
                let jsonData = result as! NSDictionary
               // print(jsonData.value(forKey: "error"))s
                print("1.2")
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
            
                   // loop through to get patient_id from arrayObject
                    if  let returned_weight = jsonData.value(forKey: "weight") as? [[String:Any]],
                       let patient = returned_weight.first {
                        self.pat_id = patient["patient_id"] as! String
                        
                        self.pat_date_weight = patient["date"] as! String
                        self.pat_weight = patient["weight"] as! String
                        
                        
                        
                      //  print (self.pat_id)
                        //print (self.pat_weight)
                        //print (self.pat_date_weight)
                        
                        self.weightLabel.text = self.pat_weight
                        self.weightDateLabel.text = self.pat_date_weight
                        
                    }
                    
                 
                    
                    
                }else{
                    
                    print("no value from weight")
                    
                  //  self.resultLabel.text = "invalid email and password"
                }
            }
            
            
        }
        
        //  Temperature
        
        AF.request(url_temperature, method:.get).responseJSON
        {
            response in
            
            print(response)
            
            if let result = response.value{
                print("2")
                let jsonData = result as! NSDictionary
               // print(jsonData.value(forKey: "error"))s
                print("2.2")
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
            
                    
                    // loop through to get patient_id from arrayObject
                     if  let returned_temperature = jsonData.value(forKey: "temperature") as? [[String:Any]],
                        let patient = returned_temperature.first {
                         self.pat_id = patient["patient_id"] as! String
                         
                         self.pat_date_temperature = patient["date"] as! String
                         self.pat_temperature = patient["temperature"] as! String
                         
                         
                         
                    //     print (self.pat_id)
                      //   print (self.pat_temperature)
                        // print (self.pat_date_temperature)
                         
                        self.temperatureLabel.text = self.pat_temperature
                         self.temperatureDateLabel.text = self.pat_date_temperature
                         
                     }
                     
                   
 
                   
                    
                    
                    
                }else{
                    
                    print("no value from temperature")
                    
                  //  self.resultLabel.text = "invalid email and password"
                }
            }
            
            
        }
        
        
        
        //  Heart
        
        AF.request(url_heart, method:.get).responseJSON
        {
            response in
            
            print(response)
            
            if let result = response.value{
                print("3")
                let jsonData = result as! NSDictionary
               // print(jsonData.value(forKey: "error"))s
                print("3.2")
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
            
                    
                    // loop through to get patient_id from arrayObject
                     if  let returned_heart = jsonData.value(forKey: "heart") as? [[String:Any]],
                        let patient = returned_heart.first {
                         self.pat_id = patient["patient_id"] as! String
                         
                         self.pat_date_heart = patient["date"] as! String
                         self.pat_heart = patient["heart"] as! String
                         
                         
                         
                         print (self.pat_id)
                         print (self.pat_heart)
                         print (self.pat_date_heart)
                         
                         self.heartLabel.text = self.pat_heart
                         self.heartDateLabel.text = self.pat_date_heart
                         
                     }
                     
                   
 
                   
                    
                    
                    
                }else{
                    
                    print("no value from heart")
                    
                  //  self.resultLabel.text = "invalid email and password"
                }
            }
            
            
        }
        
        
        
        //  systolic
        
        AF.request(url_sys, method:.get).responseJSON
        {
            response in
            
            print(response)
            
            if let result = response.value{
                print("3")
                let jsonData = result as! NSDictionary
               // print(jsonData.value(forKey: "error"))s
                print("3.2")
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
            
                    
                    // loop through to get patient_id from arrayObject
                     if  let returned_heart = jsonData.value(forKey: "sys") as? [[String:Any]],
                        let patient = returned_heart.first {
                         self.pat_id = patient["patient_id"] as! String
                         
                       
                         self.pat_sys = patient["systolic"] as! String
                         
                         
                         
                         print (self.pat_id)
                         print (self.pat_sys)
                 
                         
                         self.sysLabel.text = self.pat_sys
                     
                         
                     }
                     
                   
 
                   
                    
                    
                    
                }else{
                    
                    print("no value from Systolic")
                    
                  //  self.resultLabel.text = "invalid email and password"
                }
            }
            
            
        }

        //  dia
        
        AF.request(url_dia, method:.get).responseJSON
        {
            response in
            
            print(response)
            
            if let result = response.value{
                print("3")
                let jsonData = result as! NSDictionary
               // print(jsonData.value(forKey: "error"))s
                print("3.2")
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
            
                    
                    // loop through to get patient_id from arrayObject
                     if  let returned_dia = jsonData.value(forKey: "dia") as? [[String:Any]],
                        let patient = returned_dia.first {
                         self.pat_id = patient["patient_id"] as! String
                         
                         self.pat_date_dia = patient["date"] as! String
                         self.pat_dia = patient["diastolic"] as! String
                         
                         
                         
                      //   print (self.pat_id)
                        print (self.pat_dia)
                       //  print (self.pat_date_heart)
                         
                        self.diaLabel.text = self.pat_dia
                        self.diaDateLabel.text = self.pat_date_dia
                         
                     }
                     
                   
 
                   
                    
                    
                    
                }else{
                    
                    print("no value from heart")
                    
                  //  self.resultLabel.text = "invalid email and password"
                }
            }
            
            
        }
        
        
        
        //  spo2
        
        AF.request(url_spo2, method:.get).responseJSON
        {
            response in
            
            print(response)
            
            if let result = response.value{
                print("3")
                let jsonData = result as! NSDictionary
               // print(jsonData.value(forKey: "error"))s
                print("3.2")
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
            
                    
                    // loop through to get patient_id from arrayObject
                     if  let returned_spo2 = jsonData.value(forKey: "spo2") as? [[String:Any]],
                        let patient = returned_spo2.first {
                         self.pat_id = patient["patient_id"] as! String
                         
                         self.pat_date_spo2 = patient["date"] as! String
                         self.pat_spo2 = patient["spo2"] as! String
                         
                         
                         
                         print (self.pat_id)
                         print (self.pat_spo2)
                         print (self.pat_date_spo2)
                         
                         self.spo2Label.text = self.pat_spo2
                         self.spo2DateLabel.text = self.pat_date_spo2
                         
                     }
                     
                   
 
                   
                    
                    
                    
                }else{
                    
                    print("no value from heart")
                    
                  //  self.resultLabel.text = "invalid email and password"
                }
            }
            
            
        }
        
        
        //resp
        
        
        AF.request(url_resp, method:.get).responseJSON
        {
            response in
            
            print(response)
            
            if let result = response.value{
                print("3")
                let jsonData = result as! NSDictionary
               // print(jsonData.value(forKey: "error"))s
                print("3.2")
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
            
                    
                    // loop through to get patient_id from arrayObject
                     if  let returned_resp = jsonData.value(forKey: "resp") as? [[String:Any]],
                        let patient = returned_resp.first {
                         self.pat_id = patient["patient_id"] as! String
                         
                         self.pat_date_respiration = patient["date"] as! String
                         self.pat_respiraton = patient["fvc"] as! String
                         
                      
                         
                         self.respirationLabel.text = self.pat_respiraton
                         self.respirationDateLabel.text = self.pat_date_respiration
                         
                     }
                     
                   
 
                   
                    
                    
                    
                }else{
                    
                    print("no value from heart")
                    
                  //  self.resultLabel.text = "invalid email and password"
                }
            }
            
            
        }
        
        
        //Appointment
        
        
        AF.request(url_appoint, method:.get).responseJSON
        {
            response in
            
            print(response)
            
            if let result = response.value{
                print("63")
                let jsonData = result as! NSDictionary
               // print(jsonData.value(forKey: "error"))s
                print("33.2")
                if(!(jsonData.value(forKey: "error") as! Bool)){
                    
            
                    
                    // loop through to get patient_id from arrayObject
                     if  let returned_appoint = jsonData.value(forKey: "appoint") as? [[String:Any]],
                        let patient = returned_appoint.first {
                    //     self.pat_id = patient["patient_id"] as! String
                        
                         
                         self.pat_date_appointment = patient["avail_day"] as! String
                        self.pat_date_starttime = patient["start_time"] as! String
                      //   self.pat_respiraton = patient["fvc"] as! String
                        
                        print (self.pat_date_appointment)
                        
                        print ("elfiveoifvoei")
                      
                         
                         self.appointmentLabel.text = self.pat_date_appointment
                         self.appointmenttimeLabel.text = self.pat_date_starttime
                         
                     }
                     
                   
 
                   
                    
                    
                    
                }else{
                    
                    print("no value from heart")
                    
                  //  self.resultLabel.text = "invalid email and password"
                }
            }
            
            
        }
        
    }
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
    
    }
    
    
    
    
    
    
    
    
        
        
        
        
        
        
        
        
    
    
    
    // called whenever a tab button is tapped
      

    




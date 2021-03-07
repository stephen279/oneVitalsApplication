
import UIKit
import Alamofire
import HealthKit



class AddNewViewController: UIViewController {
    
    public var val:String!
    public var val1:String!
    public var val2:String!
    public var val3:String!
    
    public var date:String!
    public var date1:String!
    public var date2:String!
    public var date3:String!
    
    public var pat_id:Int!
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    
   

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var textFieldID: UITextField!
    
    @IBOutlet var textyFieldTemperatureDate: UITextField!
    
    @IBOutlet var textFieldTemperature: UITextField!
    
    @IBOutlet weak var textFieldDate: UITextField!
    
    @IBOutlet weak var textFieldWeight: UITextField!
    
    @IBOutlet var textFieldSpo2Date: UITextField!
    @IBOutlet var textFieldSpo2: UITextField!
    
    @IBOutlet var textFieldRespDate: UITextField!
    @IBOutlet var textFieldResp: UITextField!
    
    
    @IBOutlet var textFieldFvcDate: UITextField!
    
    @IBOutlet var textFieldFvc: UITextField!
    var final_id = ""
    
    
    
    
    var URL_NEW_RECORD = "http://www.onevitals.com/accounts/Api_ci/save_weight_api_ci"
    var URL_NEW_TEMP_RECORD = "http://www.onevitals.com/accounts/Api_ci/save_temperature_api_ci"
    var URL_USER_LOGIN = "http://www.onevitals.com/accounts/Api_ci/login_api_ci"
 
    var URL_NEW_SPO2_RECORD = "http://www.onevitals.com/accounts/Api_ci/save_spo2_api_ci"
    
    
    var URL_NEW_RESP_RECORD = "http://www.onevitals.com/accounts/Api_ci/save_resp_api_ci"
    
    
    override func viewDidLoad(){
        
      
    
    super.viewDidLoad()
        textFieldID.isHidden = true
        print("loaded", self.final_id )
        textFieldID.text = self.final_id
       // patient_nameLabel.text = self.final_name
        self.authorizeHealthKitinApp()
        errorLabel.isHidden = true
        
    }
    

  //  @IBAction func AuthorizeKitClicked(_ sender: Any) {
        
   //   self.authorizeHealthKitinApp()
    //}
    
    
    @IBAction func getDetails(_ sender: Any) {
        let weightType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let temperatureType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!
        let spo2Type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.oxygenSaturation)!
        
        let (weight, date) = self.readProfile()
        let (temperature, date1) = self.readProfile1()
        let (spo2, date2) = self.readProfile2()
        let (respiration, date3) = self.readProfile3()
    
     //  self.textFieldWeight.text =   (String(describing: weight))
     
       
    }
    
    
    
    func readProfile() ->( weight:String?, Date:String? ){
        
       
        let weightType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
 
        let temperatureType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!

    
        
        let query: HKSampleQuery = HKSampleQuery(sampleType: weightType, predicate: nil, limit: 2,  sortDescriptors: [
            
           // NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              //     ascending: true)
            
         //   NSSortDescriptor(key: "last",  ascending: true)
        ])
        
    
        
        { (query, results, error) in
            if let result_weight = results?.last as? HKQuantitySample{
                self.val = (String(describing: result_weight.quantity))
                self.date = (String(describing: result_weight.endDate))
                print("Weight inside => \(String(describing: self.val))")
                print("Date inside => \(String(describing: self.date))")
                
               // dateFormatter.stringFromDate(val.startDate)
            
                DispatchQueue.main.async {
                    
                   
                    self.textFieldWeight.text =   (self.val)
                    self.textFieldDate.text =   (self.date)
                    
                }
                
                }else{
                print("OOPS didnt get Weight \nResults => \(String(describing: results)), error => \(String(describing: error))")
             //   self.errorLabel.text = ("OOPS didnt get Weight \nResults => \(results), error => \(error)")
            }
        }
        
        
       
         
   self.healthKitStore.execute(query)
        

            
        
       
        print("Weight outside => \(String(describing: self.val))")

        return (String(describing: self.val) , "23")
 
        
  
        
    }
    
    
    func readProfile1() ->( temperature:String?, Date:String? ){
        
       
       //  let temperatureType= HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
 
        let temperatureType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!

    
        
        let query: HKSampleQuery = HKSampleQuery(sampleType: temperatureType, predicate: nil, limit: 2,  sortDescriptors: [
            
           // NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              //     ascending: true)
            
         //   NSSortDescriptor(key: "last",  ascending: true)
        ])
        
    
        
        { (query, results, error) in
            if let result_temp = results?.last as? HKQuantitySample{
                self.val1 = (String(describing: result_temp.quantity))
                self.date1 = (String(describing: result_temp.endDate))
                print("temp inside => \(String(describing: self.val1))")
                print("Date inside => \(String(describing: self.date1))")
                
               // dateFormatter.stringFromDate(val.startDate)
            
                DispatchQueue.main.async {
                    
                   
                    self.textFieldTemperature.text =   (self.val1)
                    self.textyFieldTemperatureDate.text =   (self.date1)
                    
                }
                
                }else{
                print("OOPS didnt get temp \nResults => \(String(describing: results)), error => \(String(describing: error))")
             //   self.errorLabel.text = ("OOPS didnt get Weight \nResults => \(results), error => \(error)")
            }
        }
        
        
       
         
   self.healthKitStore.execute(query)
        

            
        
       
        print("temp outside => \(String(describing: self.val))")

        return (String(describing: self.val) , "23")
 
        
  
        
    }
    
    
    
    func readProfile2() ->( spo2:String?, Date:String? ){
        
       
       //  let temperatureType= HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
 
        let spo2Type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.oxygenSaturation)!

    
        
        let query: HKSampleQuery = HKSampleQuery(sampleType: spo2Type, predicate: nil, limit: 2,  sortDescriptors: [
            
           // NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              //     ascending: true)
            
         //   NSSortDescriptor(key: "last",  ascending: true)
        ])
        
    
        
        { (query, results, error) in
            if let result_spo2 = results?.last as? HKQuantitySample{
                self.val2 = (String(describing: result_spo2.quantity))
                self.date2 = (String(describing: result_spo2.endDate))
                print("spo2 inside => \(String(describing: self.val2))")
                print("Date inside => \(String(describing: self.date2))")
                
               // dateFormatter.stringFromDate(val.startDate)
            
                DispatchQueue.main.async {
                    
                   
                    self.textFieldSpo2.text =   (self.val2)
                    self.textFieldSpo2Date.text =   (self.date2)
                    
                }
                
                }else{
                print("OOPS didnt get spo2 \nResults => \(String(describing: results)), error => \(String(describing: error))")
             //   self.errorLabel.text = ("OOPS didnt get Weight \nResults => \(results), error => \(error)")
            }
        }
        
        
       
         
   self.healthKitStore.execute(query)
        

            
        
       
        print("temp outside => \(String(describing: self.val))")

        return (String(describing: self.val2) , "23")
 
        
  
        
    }
    
    
    
    func readProfile3() ->( fvc:String?, Date:String? ){
        
       
       //  let temperatureType= HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
 
        let fvcType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.forcedVitalCapacity)!

    
        
        let query: HKSampleQuery = HKSampleQuery(sampleType: fvcType, predicate: nil, limit: 2,  sortDescriptors: [
            
           // NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              //     ascending: true)
            
         //   NSSortDescriptor(key: "last",  ascending: true)
        ])
        
    
        
        { (query, results, error) in
            if let result_fvc = results?.last as? HKQuantitySample{
                self.val3 = (String(describing: result_fvc.quantity))
                self.date3 = (String(describing: result_fvc.endDate))
                print("fvc inside => \(String(describing: self.val3))")
                print("Date inside => \(String(describing: self.date3))")
                
               // dateFormatter.stringFromDate(val.startDate)
            
                DispatchQueue.main.async {
                    
                   
                    self.textFieldFvc.text =   (self.val3)
                    self.textFieldFvcDate.text =   (self.date3)
                    
                }
                
                }else{
                print("OOPS didnt get spo2 \nResults => \(String(describing: results)), error => \(String(describing: error))")
             //   self.errorLabel.text = ("OOPS didnt get Weight \nResults => \(results), error => \(error)")
            }
        }
        
        
       
         
   self.healthKitStore.execute(query)
        

            
        
       
        print("fvc outside => \(String(describing: self.val))")

        return (String(describing: self.val) , "23")
 
        
  
        
    }
    

    @IBAction func BackButton(_ sender: Any) {
        
        //Set up a seugue for back button
        
       // let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       
       // let newViewController = storyboard!.instantiateViewController(withIdentifier: "UITabbarViewController") as! UITabbarViewController
      //  self.present(newViewController, animated: true, completion: nil)
        
        
      
        
        
        /*
         
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
         
         
         
         */
        
        
    }
    

    
    
    
    func authorizeHealthKitinApp(){
        
        
        
        
        // Use a sortDescriptor to get the recent data first
        //let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let healthKitTypesToRead : Set<HKObjectType> = [
           
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            
            HKObjectType.quantityType(forIdentifier: .bodyTemperature)!,
            
            HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!,
            
            HKObjectType.quantityType(forIdentifier: .forcedVitalCapacity)!,
            
          //  HKObjectType.quantityType(forIdentifier: .date)!,
          //  HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.date)!,
    ]
        let healthKitTypesToWrite: Set<HKSampleType> = [
            
            
        ]
        
        if !HKHealthStore.isHealthDataAvailable() {
            
            print("Error");
            return
            
        
    }
        
        //Success does NOT necessarily mean we are authorized, only that the request was successfully delivered.  Also if a user chooses not to authorize, if you call .requestAuthorization again you won't get the action sheet
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) in
            if !success {
                print("failed HealthKit Authorization from iPhone SetUpWatchVC \(String(describing: error?.localizedDescription))")
            }

            print("Successful HealthKit Authorization from iPhone")
            }
        
    }
    
    

    
    @IBAction func saveWeightRecord(_ sender: Any) {
       
            
            let parameters: Parameters = ["patient_id":textFieldID.text!, "weight":textFieldWeight.text!, "date":textFieldDate.text!]
            
        
            AF.request(URL_NEW_RECORD, method: .get, parameters: parameters).responseJSON
            {
                response in
                
                print(response)
                
                if let result = response.value{
                    print("2")
                    let jsonData = result as! NSDictionary
                   // print(jsonData.value(forKey: "error"))
                    print("2.2")
                    
                    self.errorLabel.text = jsonData.value(forKey: "message") as! String?
                    let alert = UIAlertController(title: "Save Status", message:  self.errorLabel.text, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                          switch action.style{
                          case .default:
                                print("default")

                          case .cancel:
                                print("cancel")

                          case .destructive:
                                print("destructive")


                    }}))
                    self.present(alert, animated: true, completion: nil)
                    
                  
                  
                }
                
                
            }
        
    }
        
    @IBAction func saveTemperatureRecord(_ sender: Any) {
        let parameters: Parameters = ["patient_id":textFieldID.text!, "temperature":textFieldTemperature.text!, "date":textyFieldTemperatureDate.text!]
        
        print("after let paratmaters")
        AF.request(URL_NEW_TEMP_RECORD, method: .get, parameters: parameters).responseJSON
        {
            response in
         
            print(response)
            
            print("inside paramters")
            
            if let result = response.value{
                print("3")
                let jsonData = result as! NSDictionary
               // print(jsonData.value(forKey: "error"))
                print("3.2")
                
                self.errorLabel.text = jsonData.value(forKey: "message") as! String?
                
                let alert = UIAlertController(title: "Save Status", message:  self.errorLabel.text, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                      switch action.style{
                      case .default:
                            print("default")

                      case .cancel:
                            print("cancel")

                      case .destructive:
                            print("destructive")


                }}))
                self.present(alert, animated: true, completion: nil)
                
              
            }
            
            
        }
        
        
        
        
        
    }
    
    
    
    @IBAction func saveSpo2Button(_ sender: Any) {
        
        
        
        
        
            let parameters: Parameters = ["patient_id":textFieldID.text!, "spo2":textFieldSpo2.text!, "date":textFieldSpo2Date.text!]
            
            print("after let paratmaters")
            AF.request(URL_NEW_SPO2_RECORD, method: .get, parameters: parameters).responseJSON
            {
                response in
             
                print(response)
                
                print("inside paramters")
                
                if let result = response.value{
                    print("3")
                    let jsonData = result as! NSDictionary
                   // print(jsonData.value(forKey: "error"))
                    print("3.2")
                    
                    self.errorLabel.text = jsonData.value(forKey: "message") as! String?
                    
                    let alert = UIAlertController(title: "save status", message: self.errorLabel.text, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                          switch action.style{
                          case .default:
                                print("default")

                          case .cancel:
                                print("cancel")

                          case .destructive:
                                print("destructive")


                    }}))
                    self.present(alert, animated: true, completion: nil)
                    
                  
                
                
                
            }
            
        
        
        
        
        
        
        
    }
    
    }
    
    @IBAction func saveRespirationRecord(_ sender: Any) {
        
        
        
            let parameters: Parameters = ["patient_id":textFieldID.text!, "fvc":textFieldResp.text!, "date":textFieldRespDate.text!]
            
            print("after let paratmaters")
            AF.request(URL_NEW_RESP_RECORD, method: .get, parameters: parameters).responseJSON
            {
                response in
             
                print(response)
                
                print("inside paramters")
                
                if let result = response.value{
                    print("3")
                    let jsonData = result as! NSDictionary
                   // print(jsonData.value(forKey: "error"))
                    print("3.2")
                    
                    self.errorLabel.text = jsonData.value(forKey: "message") as! String?
                    
                    let alert = UIAlertController(title: "Save Status", message:  self.errorLabel.text, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                          switch action.style{
                          case .default:
                                print("default")

                          case .cancel:
                                print("cancel")

                          case .destructive:
                                print("destructive")


                    }}))
                    self.present(alert, animated: true, completion: nil)
                    
                  
                }
                
        
        
    }
    
    
    }
    
    
    @IBAction func saveTempRecord(_ sender: Any) {
        
       
        
    }
    
}

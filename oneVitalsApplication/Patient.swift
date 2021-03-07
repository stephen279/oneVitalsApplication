//
//  Patient.swift
//  oneVitalsApplication
//
//  Created by stephen holland on 26/01/2021.
//

import UIKit

class Patients: Codable {
    
    let patients : [Patient]
    
    init(patients: [Patient]){
        
        self.patients = patients
    }
 

}



class Patient: Codable {
    
    
    let patientid : String
    
    init(patientid: String){
        self.patientid = patientid
    }
    
    class Weight: Codable{
        
        let weight_id : String
        
        init(weight_id: String){
            self.weight_id = weight_id
        }
    }
    
    
}

//
//  DatabaseManager.swift
//  Match22
//
//  Created by VM on 2/6/21.
//

import UIKit
import FirebaseDatabase

class DatabaseManager: NSObject {
    private override init() { }
    static let shared: DatabaseManager = DatabaseManager()
    var themeColors: [String:String]?
    
    func getData (firstRef:String, secondRef: String?, completion: @escaping(_ dataDictionary: NSDictionary?, _ dataArray: NSArray?) -> Void){
        var ref: DatabaseReference!
        ref = Database.database().reference().child(firstRef)
        
        if let secondRef = secondRef {
            ref = ref.child(secondRef)
        }
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary{
                completion(value, nil)
            }
            if let value = snapshot.value as? NSArray{
                completion(nil, value)
            }
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    func saveUser (data: NSDictionary, object: Player? = nil){
        if let userId = LoginManager.shared.userId{
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("users").child(userId).setValue(data)
            LoginManager.shared.userData = object
            
        }
    }
}

//
//  LoginManager.swift
//  Match22
//
//  Created by VM on 11/7/20.
//

import UIKit
import FirebaseAuth

let kLoginManagerIsLoggedIn = "loggedInKey"
let kLoginManagerUserId = "userIdKey"
class LoginManager: NSObject {
    private override init() { }
    static let shared: LoginManager = LoginManager()
    var isLoggedIn: Bool{
        get{
            return UserDefaults.standard.bool(forKey: kLoginManagerIsLoggedIn)
        }
        set(isLoggedIn){
            UserDefaults.standard.setValue(isLoggedIn, forKey: kLoginManagerIsLoggedIn)
        }
    }
    var userId : String?{
        get{
            return UserDefaults.standard.string(forKey: kLoginManagerUserId)
        }
        set(userId){
            UserDefaults.standard.setValue(userId, forKey: kLoginManagerUserId)
        }
    }
    func login(email: String, pass: String, completion: @escaping(_ success: Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: pass) {  [weak self] authResult, error in
            guard let _ = authResult else {
                self?.isLoggedIn = false
                self?.userId = nil
                completion(false)
                return
            }
            self?.isLoggedIn = true
            self?.userId = authResult?.user.uid
            
            print("login manager login")
            completion(self?.isLoggedIn ?? false)
        }
        
    }
}

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
let kLoginManagerUserData = "userDataKey"
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
    var userData : Player?{
        get{
            do{
                let player = try JSONDecoder().decode(Player.self, from: UserDefaults.standard.object(forKey: kLoginManagerUserData) as! Data)
                return player
            }
            catch{
                print(error)
                return nil
            }
        }
        set(userData){
            do{
                let data = try JSONEncoder().encode(userData)
                UserDefaults.standard.setValue(data, forKey: kLoginManagerUserData)
            }
            catch{
                print(error)
            }
            
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
            
            DatabaseManager.shared.getData(firstRef:"users", secondRef: self?.userId, completion:{(dictionary, array) in
                guard let userObject = dictionary else{
                    return
                }
                
                do{
                    let json = try JSONSerialization.data(withJSONObject: userObject, options: .prettyPrinted)
                    var player = try JSONDecoder().decode(Player.self, from: json)
                    player.id = self?.userId
                    self?.userData = player
                }
                catch{
                    print(error)
                }
                
            })
            
            
            print("login manager login")
            completion(self?.isLoggedIn ?? false)
        }
        
    }
}

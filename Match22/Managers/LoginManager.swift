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
            return UserDefaults.standard.object(forKey: kLoginManagerUserData) as? Player
        }
        set(userData){
            UserDefaults.standard.setValue(userData, forKey: kLoginManagerUserData)
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
                guard let value = dictionary else{
                    return
                }
                let username = value["name"] as? String ?? ""
                let bestScore = value["bestScore"] as? Double
                let bestLevel = value["bestLevel"] as? Int
                let bestTime = value["bestTime"] as? String
                let levelsDoneDictionary = value["levelsDone"] as? [NSDictionary] ?? [NSDictionary]()
                
                var levelsDone = [LevelDone]()
                for levelDone in levelsDoneDictionary{
                    let id = levelDone["id"] as! Int
                    let score = levelDone["score"] as! Double
                    let time = levelDone["time"] as! String
                    levelsDone.append(LevelDone(id: id, score: score, time: time))
                }
                let player = Player(name: username, id: self?.userId ?? "")
                player.bestScore = bestScore
                player.bestLevel = bestLevel
                player.bestTime = bestTime
                player.levelsDone = levelsDone
                
                self?.userData = player
            })
            
            
            print("login manager login")
            completion(self?.isLoggedIn ?? false)
        }
        
    }
}

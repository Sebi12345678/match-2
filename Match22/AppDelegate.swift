//
//  AppDelegate.swift
//  Match2
//
//  Created by Sebi on 11/10/2020.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        DatabaseManager.shared.getData(firstRef: "themes", secondRef: nil, completion: {
            dictionary, _ in
            DatabaseManager.shared.themeColors = dictionary as? Dictionary<String,String>
        })
        DatabaseManager.shared.getData(firstRef:"users", secondRef: LoginManager.shared.userId ?? "", completion:{(dictionary, array) in
            guard let userObject = dictionary else{
                return
            }
            
            do{
                let json = try JSONSerialization.data(withJSONObject: userObject, options: .prettyPrinted)
                var player = try JSONDecoder().decode(Player.self, from: json)
                player.id = LoginManager.shared.userId
                LoginManager.shared.userData = player
            }
            catch{
                print(error)
            }
            
        })
        return true
        
    }
    //hello

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


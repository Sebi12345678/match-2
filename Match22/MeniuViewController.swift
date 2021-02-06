//
//  MeniuViewController.swift
//  Match2
//
//  Created by Sebi on 11/10/2020.

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class MeniuViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var testImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId = LoginManager.shared.userId
        
        DatabaseManager.shared.getData(firstRef:"users", secondRef: userId, completion:{(dictionary, array) in
            guard let value = dictionary else{
                return
            }
            let username = value["name"] as? String ?? ""
            self.userNameLabel.text = username
        })
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        LoginManager.shared.userId = nil
        LoginManager.shared.isLoggedIn = false
        
        let mainController = storyboard?.instantiateViewController(identifier: "LoginViewController")
        UIApplication.shared.windows.first?.rootViewController = mainController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    @IBAction func exitAction(_ sender: Any) {
        exit(-1)
    }
    
}

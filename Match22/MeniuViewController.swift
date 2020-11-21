//
//  MeniuViewController.swift
//  Match2
//
//  Created by Sebi on 11/10/2020.

import UIKit
import FirebaseAuth

class MeniuViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameLabel.text = LoginManager.shared.userId
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

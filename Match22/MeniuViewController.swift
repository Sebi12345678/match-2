//
//  MeniuViewController.swift
//  Match2
//
//  Created by Sebi on 11/10/2020.

import UIKit
import FirebaseAuth
import FirebaseStorage

class MeniuViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var testImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = LoginManager.shared.userId
        
        StorageManager.shared.getImage(name: "disruptor.jpg", completion: {
            image in self.testImageView.image = image
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

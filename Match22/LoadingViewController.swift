//
//  LoadingViewController.swift
//  Match22
//
//  Created by VM on 10/30/20.
//

import UIKit
import FirebaseAuth

class LoadingViewController: UIViewController {

    var handle : AuthStateDidChangeListenerHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        var mainController = self.storyboard?.instantiateViewController(identifier: "LoginViewController")
        if LoginManager.shared.isLoggedIn{
            mainController = self.storyboard?.instantiateViewController(identifier: "mainApplicationControlller")
        }
        UIApplication.shared.windows.first?.rootViewController = mainController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

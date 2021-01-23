//
//  ViewController.swift
//  Match2
//
//  Created by Sebi on 11/10/2020.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var nameInputField: UITextField!
    
    @IBOutlet weak var passInputField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }

    
    @IBAction func loginAction(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        loginButton.isEnabled = false
        if let name = nameInputField.text,
           let pass = passInputField.text
        {
            LoginManager.shared.login(email: name, pass: pass, completion: {success in
                if success == true{
                    print("login go to menu")
                    let mainController = self.storyboard?.instantiateViewController(identifier: "mainApplicationControlller")
                    UIApplication.shared.windows.first?.rootViewController = mainController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    
                }
                else
                {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.loginButton.isEnabled = true
                    
                    let dialogMessage = UIAlertController(title: "Atentie", message: "Nume sau parola gresite", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                      })
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                }
                
            })
        }
    }
    
}


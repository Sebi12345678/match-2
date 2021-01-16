//
//  RegisterViewController.swift
//  Match22
//
//  Created by VM on 11/14/20.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {

    @IBOutlet weak var nameInputField: UITextField!
    @IBOutlet weak var emailInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var repeatPasswordInputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //d Do any additional setup after loading the view.
    }
    
    @IBAction func registerAction(_ sender: Any) {
        var errorMessage = ""
        
        if ((nameInputField.text?.isEmpty) == true){
            errorMessage+="Name is empty \n"
        }
        if ((emailInputField.text?.isValidEmail()) == false) {
            errorMessage+="Email not valid \n"
        }
        if passwordInputField.text != repeatPasswordInputField.text {
            errorMessage+="Password doesn't match \n"
            }
        if passwordInputField.text?.count ?? 0<8 {
            errorMessage+="Password too short \n"
        }
        
        
        if !errorMessage.isEmpty {
            let dialogMessage = UIAlertController(title: "Atentie", message: errorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
              })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            
            return
        }
        if let email = emailInputField.text, let password = passwordInputField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                //let userId = authResult?.user.uid
                //var ref: DatabaseReference!
                //ref = Database.database().reference()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
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

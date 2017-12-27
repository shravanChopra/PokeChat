//
//  LoginVC.swift
//  PokeChat
//
//  Created by Shravan Chopra on 27/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: ShakyTextField!
    @IBOutlet weak var passwordTextField: ShakyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        // Guard against blank text entry
        if emailTextField.text == nil || emailTextField.text == "" {
            emailTextField.shake()
        }
        else if passwordTextField.text == nil || passwordTextField.text == "" {
            passwordTextField.shake()
        }
        else {
            
            // Log the user in
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
                if (error != nil) {
                    print (error.debugDescription)
                }
                else {
                    print ("Signed in successful!")
                    self.performSegue(withIdentifier: "toChatVC", sender: self)
                }
            })
        }
    }
    
    // TODO - try to get the pokemon avatar data once they log in!
    
    // -------------------------------------------------------------------------------------------
    
    // MARK - TextField protocol methods (basically to dismiss the keyboard when the user touches outside the textfields)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

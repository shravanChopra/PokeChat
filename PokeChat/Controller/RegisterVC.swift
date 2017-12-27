//
//  RegisterVC.swift
//  PokeChat
//
//  Created by Shravan Chopra on 26/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // to register pokemon avatar along with user
    private var _pokeID: String!
    public var pokeID: String {
        get { return _pokeID }
        set { _pokeID = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // display the correct avatar
        pokeImage.image = UIImage(named: _pokeID)
    }
    
    
    // Function - registers a new user to the Firebase DB
    @IBAction func finishBtnPressed(_ sender: UIButton) {
        
        // TODO - guard against blank text entry
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if (error != nil) {
                print (error.debugDescription)
            }
            else {
                print ("Registration successful!!")
                self.performSegue(withIdentifier: "toChatVC", sender: self)
            }
        }
    }
    
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

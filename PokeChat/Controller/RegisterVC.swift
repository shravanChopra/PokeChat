//
//  RegisterVC.swift
//  PokeChat
//
//  Created by Shravan Chopra on 26/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController, UITextFieldDelegate, Shakeable {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var emailTextField: ShakyTextField!
    @IBOutlet weak var passwordTextField: ShakyTextField!

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
        
        // Guard against blank text entry
        if emailTextField.text == nil || emailTextField.text == "" {
            emailTextField.shake()
        }
        else if passwordTextField.text == nil || passwordTextField.text == "" {
            passwordTextField.shake()
        }
        else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if (error != nil) {
                    print (error.debugDescription)
                }
                else {
                    print ("Registration successful!!")
                    
                    // save pokeAvatar data and transition to Chats
                    self.uploadPokeAvatar()
                    self.performSegue(withIdentifier: "toChatVC", sender: self)
                }
            }
        }
    }
    
    // Function - save the user's pokeAvatar info to DB
    private func uploadPokeAvatar() {
       
        let userAvatarsDB = Database.database().reference().child("UserAvatarsDB")
        let userAvatar = ["User": emailTextField.text!, "PokeAvatar": _pokeID]

        userAvatarsDB.childByAutoId().setValue(userAvatar) {
            
            (error, reference) in
            
            if (error != nil) {
                print (error.debugDescription)
            }
            else {
                print ("User info saved successfully!")
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

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
    
    // to store avatar info of logged in user
    private var _pokeID: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "LOGIN"
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
                    
                    // get avatar data and pass it along
                    self.getAvatarData()
                    
                }
            })
        }
    }
    
    // Function - get the avatar data of current user
    private func getAvatarData() {
        let userAvatarsDB = Database.database().reference().child("UserAvatarsDB")
        
        let username = emailTextField.text!.components(separatedBy: ".")[0]
        
        userAvatarsDB.child(username).observeSingleEvent(of: .value) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            self._pokeID = snapshotValue["PokeAvatar"]!
            self.performSegue(withIdentifier: "toChatVC", sender: self)
        }
    }
    
    // Function - pass along pokeAvatar info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chatVC = segue.destination as? ChatVC {
            if let thisVC = sender as? LoginVC {
                chatVC.currentPokeId = thisVC._pokeID
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

//
//  ChatVC.swift
//  PokeChat
//
//  Created by Shravan Chopra on 27/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    // to store avatar of current user
    private var _currentPokeId: String!
    public var currentPokeId: String {
        get { return _currentPokeId }
        set { _currentPokeId = newValue }
    }
    
    // to adjust textfield when the keyboard appears and disappears
    @IBOutlet weak var newMsgViewHeight: NSLayoutConstraint!
    
    // to store and display all messages
    @IBOutlet weak var messagesTableView: UITableView!
    
    // to compose new messages
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
        
        // to dismiss keyboard when user taps outside the textfield
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(tappedOutside))
        messagesTableView.addGestureRecognizer(tapGesture)
       
    }

    // Function - does initial setup
    private func initialSetup() {
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.separatorStyle = .none
        
        messageTextField.delegate = self
    }
    
    // ---------------------------------------------------------------------------------------------
    
    // MARK - tableView protocol methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
    // ---------------------------------------------------------------------------------------------
    
    // MARK - textfield delegate methods
    
    // Function - increase the height of the view to accommodate the keyboard
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            
            self.newMsgViewHeight.constant = 318
            self.view.layoutIfNeeded()
        }
    }
    
    // Function - reset the height of the view once the keyboard has been dismissed
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.newMsgViewHeight.constant = 60
            self.view.layoutIfNeeded()
        }
    }
    
    // Function - dismiss the keyboard when the user hits 'Return'
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Function - dismiss the keyboard once the user taps outside the textfield
    @objc func tappedOutside() {
        messageTextField.endEditing(true)
    }
}

//
//  ChatVC.swift
//  PokeChat
//
//  Created by Shravan Chopra on 27/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    // to store avatar of current user
    private var _currentPokeId: String!
    public var currentPokeId: String {
        get { return _currentPokeId }
        set { _currentPokeId = newValue }
    }
    
    // to compose new messages
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    // to adjust textfield when the keyboard appears and disappears
    @IBOutlet weak var newMsgViewHeight: NSLayoutConstraint!
    
    // to store and display all messages
    @IBOutlet weak var messagesTableView: UITableView!
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDelegates()
        
        // Register custom XIB file
        messagesTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        
        // to dismiss keyboard when user taps outside the textfield
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(tappedOutside))
        messagesTableView.addGestureRecognizer(tapGesture)
       
        // Get all previous chat history
        getChatHistory()
        
        // Configure table view to accommodate all messages
        configureTableView()
    }

    // Function - does initial setup
    private func setDelegates() {
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.separatorStyle = .none
        messageTextField.delegate = self
    }
    
    // ---------------------------------------------------------------------------------------------

    // MARK: - Sending and receiving messages from Firebase DB
    
    // Function - composes a new message and sends to Firebase DB
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        
        // Check for empty input
        if !(messageTextField.text == nil || messageTextField.text == "") {
            
            // Disable UI
            messageTextField.isEnabled = false
            sendButton.isEnabled = false
            
            // get reference to messages database
            let messagesDB = Database.database().reference().child("Messages")
            
            // compose new message and store it with a unique ID
            let messageDict = ["Sender": Auth.auth().currentUser?.email,
                               "Avatar": _currentPokeId,
                               "MessageBody": messageTextField.text!]
        
            messagesDB.childByAutoId().setValue(messageDict) {
                (error, reference) in
                
                if (error != nil) {
                    print (error.debugDescription)
                }
                else {
                    print ("Message sent successfully!")
                    
                    // re-enable UI
                    self.messageTextField.isEnabled = true
                    self.sendButton.isEnabled = true
                    
                    // finally, clear the textfield
                    self.messageTextField.text = ""
                }
            }
            
        }
    
    }
    
    // Function - retrieves entire chat history
    private func getChatHistory() {
        
        // get reference to messages database
        let messagesDB = Database.database().reference().child("Messages")
    
        // observe for new messages
        messagesDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            // pull out the data
            let sender = snapshotValue["Sender"]!
            let pokeAvatar = snapshotValue["Avatar"]!
            let messageText = snapshotValue["MessageBody"]!
            
            print("\(sender): \(pokeAvatar) wrote: \(messageText)")
            
            // save as a new message and add to messages array
            self.messages.append(Message(sender: sender, pokeAvatar: pokeAvatar, messageText: messageText))
            
            // update tableview
            self.configureTableView()
            self.messagesTableView.reloadData()        
        }
        
    }
    
    // ---------------------------------------------------------------------------------------------
    
    // MARK - tableView protocol methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let messageCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell {
            
            messageCell.configure(from: messages[indexPath.row])
            return messageCell
        }
        
        return UITableViewCell()
    }
    
    // Function - adjust tableview to accommodate messages of varying heights
    private func configureTableView() {
        messagesTableView.rowHeight = UITableViewAutomaticDimension
        messagesTableView.estimatedRowHeight = 120.0
    }
    
    // ---------------------------------------------------------------------------------------------
    
    // MARK: - textfield delegate methods
    
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
    
    // Function - dismiss the keyboard once the user taps outside the textfield
    @objc func tappedOutside() {
        messageTextField.endEditing(true)
    }
}

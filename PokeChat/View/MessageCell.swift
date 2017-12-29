//
//  MessageCell.swift
//  PokeChat
//
//  Created by Shravan Chopra on 28/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {

    // to display message info
    @IBOutlet var otherUserAvatar: UIImageView!
    @IBOutlet var currentUserAvatar: UIImageView!
    @IBOutlet var msgTextLbl: UILabel!
    @IBOutlet var senderLbl: UILabel!
    @IBOutlet var msgBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        msgBackgroundView.layer.cornerRadius = 10
    }

    func configure(from message: Message) {
        
        msgTextLbl.text = message.messageText
        senderLbl.text = message.sender

        if message.sender == Auth.auth().currentUser?.email {
            setupAsCurrentUser(message.pokeAvatar)
        }
        else {
            setupAsOther(message.pokeAvatar)
        }
    }
    
    private func setupAsCurrentUser(_ pokeAvatar: String) {
        otherUserAvatar.isHidden = true
        currentUserAvatar.isHidden = false
        currentUserAvatar.image = UIImage(named: pokeAvatar)
        
        msgBackgroundView.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.8984614647)
        senderLbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        senderLbl.textAlignment = .right
        msgTextLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        msgTextLbl.textAlignment = .right
    }
    
    private func setupAsOther(_ pokeAvatar: String) {
        otherUserAvatar.isHidden = true
        otherUserAvatar.image = UIImage(named: pokeAvatar)
        currentUserAvatar.isHidden = true

        senderLbl.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        msgTextLbl.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        msgBackgroundView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        msgTextLbl.textAlignment = .left
        senderLbl.textAlignment = .left
    }
}

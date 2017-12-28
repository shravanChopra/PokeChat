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
    @IBOutlet weak var otherUserAvatar: UIImageView!
    @IBOutlet weak var currentUserAvatar: UIImageView!
    @IBOutlet weak var msgTextLbl: UILabel!
    @IBOutlet weak var senderLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        currentUserAvatar.image = UIImage(named: pokeAvatar)
   
        // TODO - change background and text colors!
    }
    
    private func setupAsOther(_ pokeAvatar: String) {
        otherUserAvatar.image = UIImage(named: pokeAvatar)
        currentUserAvatar.isHidden = true
    }
}

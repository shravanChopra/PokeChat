//
//  Message.swift
//  PokeChat
//
//  Created by Shravan Chopra on 28/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import Foundation

class Message {
    
    private var _sender: String
    private var _pokeAvatar: String
    private var _messageText: String
    
    init(sender: String, pokeAvatar: String, messageText: String) {
        _sender = sender
        _pokeAvatar = pokeAvatar
        _messageText = messageText
    }
    
    // defining getters
    public var sender: String {
        get { return _sender }
    }
    
    public var pokeAvatar: String {
        get { return _pokeAvatar }
    }
    
    public var messageText: String {
        get { return _messageText }
    }
}

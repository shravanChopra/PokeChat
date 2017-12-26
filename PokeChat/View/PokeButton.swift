//
//  PokeButton.swift
//  PokeChat
//
//  Created by Shravan Chopra on 26/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

// Custom class to give rounded corners to buttons
class PokeButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.height / 2
    }
}

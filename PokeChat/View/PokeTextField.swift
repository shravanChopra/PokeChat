//
//  PokeTextField.swift
//  PokeChat
//
//  Created by Shravan Chopra on 26/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class PokeTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.height / 2.0
    }
}

//
//  Shakeable.swift
//  PokeChat
//
//  Created by Shravan Chopra on 27/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

// Adding a small 'Shake' animation to textfields to signify empty / incorrect data entry

protocol Shakeable { }

extension Shakeable where Self: UITextField {
    
    func shake() {
        
        let anim = CABasicAnimation(keyPath: "position")
        anim.duration = 0.05
        anim.repeatCount = 5
        anim.autoreverses = true
        anim.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
        anim.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
        layer.add(anim, forKey: "position")
    }
}

// Creating an empty class that conforms to protocol
class ShakyTextField: UITextField, Shakeable { }

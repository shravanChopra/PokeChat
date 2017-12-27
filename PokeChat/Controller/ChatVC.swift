//
//  ChatVC.swift
//  PokeChat
//
//  Created by Shravan Chopra on 27/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var pokeImg: UIImageView!
    
    // to store avatar of current user
    private var _currentPokeId: String!
    public var currentPokeId: String {
        get { return _currentPokeId }
        set { _currentPokeId = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // testing avatar info
        pokeImg.image = UIImage(named: _currentPokeId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  PokeCell.swift
//  PokeChat
//
//  Created by Shravan Chopra on 26/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeNameLbl: UILabel!
    
    // Function: Update UI from details of pokemon passed in
    func configure(from pokemon: Pokemon) {
        pokeImg.image = UIImage(named: pokemon.id)
        pokeNameLbl.text = pokemon.name.capitalized
    }
}

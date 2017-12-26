//
//  PokeAvatarVC.swift
//  PokeChat
//
//  Created by Shravan Chopra on 26/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class PokeAvatarVC: UIViewController {

    // to store pokemon data
    var pokemon: [Pokemon]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pokemon = loadPokemonData()
    }
 
    
    // Function: loads all pokemon data from CSV file and returns as an array of Pokemon
    private func loadPokemonData() -> [Pokemon]! {
        
        var results = [Pokemon]()
        
        guard let filePath = Bundle.main.path(forResource: "pokemon", ofType: "csv")
            else {
                return nil
        }
        
        do {
            let contents = try String(contentsOfFile: filePath, encoding: .utf8)
            var pokeItems = contents.components(separatedBy: "\r")
            
            // removing the last one
            pokeItems.removeLast()
            
            for item in pokeItems {
                
                let pokeData = item.components(separatedBy: ",")
                let newPokemon = Pokemon(id: pokeData[0], name: pokeData[1])
                results.append(newPokemon)
            }
            
        } catch {
            print("File Read Error for file \(filePath)")
            return nil
        }
        
        print ("\(results.count) pokemon loaded")
        
        return results

    }
}

//
//  PokeAvatarVC.swift
//  PokeChat
//
//  Created by Shravan Chopra on 26/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class PokeAvatarVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // to store pokemon data
    var pokemon: [Pokemon]!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set this VC as datasource and delegate
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        
        // load pokemon data
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
    
    // -------------------------------------------------------------------------------------------
    
    // MARK - Defining methods to conform to Collection View Protocols
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let pokeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            pokeCell.configure(from: pokemon[indexPath.row])
            return pokeCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // TODO - transition to RegisterVC
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 110, height: 110)
    }
}

//
//  PokeAvatarVC.swift
//  PokeChat
//
//  Created by Shravan Chopra on 26/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class PokeAvatarVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    // to store pokemon data
    var pokemon: [Pokemon]!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    // to implement search-filtering
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredPokemon: [Pokemon]!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "CHOOSE AVATAR"
        
        
        
        // set this VC as datasource and delegate of collection view
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self

        // set this VC as delegate of search bar
        searchBar.delegate = self
        
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
        
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let pokeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            if inSearchMode {
                pokeCell.configure(from: filteredPokemon[indexPath.row])
            }
            else {
                pokeCell.configure(from: pokemon[indexPath.row])
            }
            
            return pokeCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var sendingPokemon: Pokemon
       
        if inSearchMode {
            sendingPokemon = filteredPokemon[indexPath.row]
        } else {
            sendingPokemon = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "toRegisterVC", sender: sendingPokemon)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 110, height: 110)
    }
    
    // -------------------------------------------------------------------------------------------
    
    // Function - passes the correct pokemon avatar to the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let registerVC = segue.destination as? RegisterVC {
            if let sendingPokemon = sender as? Pokemon {
                registerVC.pokeID = sendingPokemon.id
            }
        }
    }
    
    // -------------------------------------------------------------------------------------------
    
    // MARK - implementing search filtering
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            pokemonCollectionView.reloadData()
        }
        else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({ $0.name.range(of: lower) != nil })
            pokemonCollectionView.reloadData()
        }
    }
}

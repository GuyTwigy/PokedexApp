//
//  PokedexManager.swift
//  PokedexApp
//
//  Created by Guy Twig on 31/01/2024.
//

import Foundation

class PokedexManager {
    
    static let sharedInstance: PokedexManager = PokedexManager()
    
    var favoritesList: [PokemonFullDetails] = []
    
}

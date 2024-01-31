//
//  PokemonFullDetails.swift
//  PokedexApp
//
//  Created by Guy Twig on 31/01/2024.
//

import Foundation

struct PokemonFullDetails {
    var nameAndUrl: NameAndUrlData
    var details: PokemonData
    var isFav: Bool
    
    init(nameAndUrl: NameAndUrlData, details: PokemonData, isFav: Bool) {
        self.nameAndUrl = nameAndUrl
        self.details = details
        self.isFav = isFav
    }
}

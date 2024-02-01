//
//  FavoritesVM.swift
//  PokedexApp
//
//  Created by Guy Twig on 01/02/2024.
//

import Foundation

class FavoritesVM: ObservableObject {
    
    @Published var favoritesArr: [PokemonFullDetails] = [] {
        didSet {
            print("favoritesArr changed count: \(favoritesArr.count)")
        }
    }
    
    func addFavorite(_ pokemon: PokemonFullDetails) {
        if !favoritesArr.contains(where: { $0.details.id == pokemon.details.id }) {
            favoritesArr.append(pokemon)
        }
    }
    
    func removeFavorite(_ pokemon: PokemonFullDetails) {
        favoritesArr.removeAll(where: { $0.details.id == pokemon.details.id })
    }
    
    func toggleFavorite(pokemon: PokemonFullDetails, isFavorite: Bool) {
            if isFavorite {
                addFavorite(pokemon)
            } else {
                removeFavorite(pokemon)
            }
    }
}

//
//  FavoriteVM.swift
//  PokedexApp
//
//  Created by Guy Twig on 30/01/2024.
//

import Foundation

class FavoriteVM: ObservableObject {
    
    @Published var favorites: [PokemonFullDetails] = []
    
    func addFavorite(_ pokemon: PokemonFullDetails) {
        if !favorites.contains(where: { $0.details.id == pokemon.details.id }) {
            favorites.append(pokemon)
        }
    }
    
    func removeFavorite(_ pokemon: PokemonFullDetails) {
        favorites.removeAll(where: { $0.details.id == pokemon.details.id })
    }
    
    func toggleFavorite(pokemon: PokemonFullDetails, isFavorite: Bool) {
        if isFavorite {
            addFavorite(pokemon)
        } else {
            removeFavorite(pokemon)
        }
    }
}

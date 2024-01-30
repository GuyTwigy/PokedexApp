//
//  FavoriteVM.swift
//  PokedexApp
//
//  Created by Guy Twig on 30/01/2024.
//

import Foundation

class FavoriteVM: ObservableObject {
    
    @Published var favorites: [(nameAndUrl: NameAndUrlData, details: PokemonData, isFav: Bool)] = []
    
    func addFavorite(_ pokemon: (nameAndUrl: NameAndUrlData, details: PokemonData, isFav: Bool)) {
        if !favorites.contains(where: { $0.details.id == pokemon.details.id }) {
            favorites.append(pokemon)
        }
    }
    
    func removeFavorite(_ pokemon:(nameAndUrl: NameAndUrlData, details: PokemonData, isFav: Bool)) {
        favorites.removeAll(where: { $0.details.id == pokemon.details.id })
    }
}

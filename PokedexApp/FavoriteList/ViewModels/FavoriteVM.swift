//
//  FavoriteVM.swift
//  PokedexApp
//
//  Created by Guy Twig on 30/01/2024.
//

import Foundation

class FavoriteVM: ObservableObject {
    
    @Published var favorites: [PokemonFullDetails] = []
    var pokedexVM: PokedexVM
    
    init(pokedexVM: PokedexVM) {
        self.pokedexVM = pokedexVM
    }
    
    func addFavorite(_ pokemon: PokemonFullDetails) {
        if !favorites.contains(where: { $0.details.id == pokemon.details.id }) {
            var pok = pokemon
            pok.isFav = true
            favorites.append(pok)
        }
    }
    
    func removeFavorite(_ pokemon: PokemonFullDetails) {
        favorites.removeAll(where: { $0.details.id == pokemon.details.id })
    }
    
    func updateIsFav(for id: Int, isFav: Bool) {
        if let index = favorites.firstIndex(where: { $0.details.id == id }) {
            favorites.remove(at: index)
        }
        if let pokedexIndex = pokedexVM.pokemonNameAndDetails.firstIndex(where: { $0.details.id == id }) {
            pokedexVM.pokemonNameAndDetails[pokedexIndex].isFav = isFav
        }
    }
}

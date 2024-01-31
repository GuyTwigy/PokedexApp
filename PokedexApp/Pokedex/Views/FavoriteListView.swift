//
//  FavoriteListView.swift
//  PokedexApp
//
//  Created by Guy Twig on 30/01/2024.
//

import SwiftUI

struct FavoriteListView: View {
    
    @EnvironmentObject var favoriteVM: FavoriteVM

    var body: some View {
        Text("My Favorite Pokemons List")
            .font(.system(size: 35))
            .multilineTextAlignment(.center)
        List {
            ForEach(favoriteVM.favorites, id: \.details.id) { pokemon in
                PokemonFavRow(pokemonFullDetails: pokemon)
            }
        }
    }
}


//
//  FavoriteListView.swift
//  PokedexApp
//
//  Created by Guy Twig on 30/01/2024.
//

import SwiftUI

struct FavoriteListView: View {
    
    var favoriteVM: FavoriteVM

    var body: some View {
        List {
            ForEach(favoriteVM.favorites, id: \.details.id) { pokemon in
                PokemonRow(pokemonNameAndDetails: pokemon)
            }
        }
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView(favoriteVM: FavoriteVM())
    }
}

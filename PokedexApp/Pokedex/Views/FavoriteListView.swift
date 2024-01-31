//
//  FavoriteListView.swift
//  PokedexApp
//
//  Created by Guy Twig on 30/01/2024.
//

import SwiftUI

struct FavoriteListView: View {
    
    @EnvironmentObject var favoriteVM: FavoriteVM
    @EnvironmentObject var pokedexVM: PokedexVM

    var body: some View {
        List {
            ForEach(favoriteVM.favorites, id: \.details.id) { pokemon in
                PokemonRow(pokemonNameAndDetails: pokemon, rowState: .favorite)
            }
        }
    }
}

//struct FavoriteListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteListView(favoriteVM: FavoriteVM(pokedexVM: PokedexVM()))
//    }
//}

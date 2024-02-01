//
//  FavoritesView.swift
//  PokedexApp
//
//  Created by Guy Twig on 01/02/2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var favoritesVM: FavoritesVM
    
    var body: some View {
        VStack {
            Text("My Favorite Pokemons List")
                .font(.system(size: 35))
                .multilineTextAlignment(.center)
                .padding()
            
            List {
                ForEach(favoritesVM.favoritesArr, id: \.details.id) { pokemon in
                    PokemonRow(pokemonFullDetails: pokemon)
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesVM())
    }
}

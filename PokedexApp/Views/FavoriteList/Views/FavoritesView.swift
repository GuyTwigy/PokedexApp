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
        NavigationView {
            VStack {
                Text("My Favorite Pokemons List")
                    .font(.system(size: 35))
                    .multilineTextAlignment(.center)
                    .padding()
                
                if favoritesVM.favoritesArr.isEmpty {
                    Spacer()
                    Text("The favorite list is empty.")
                    Text("Go catch them all!")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(favoritesVM.favoritesArr, id: \.details.id) { pokemon in
                            PokemonRow(pokemonFullDetails: pokemon)
                        }
                    }
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

//
//  PokedexView.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import SwiftUI

struct PokedexView: View {
    
    @ObservedObject private var pokedexVM = PokedexVM()
    @EnvironmentObject var favoriteVM: FavoriteVM
    @State private var likeStates = [Int: Bool]()
    
    var body: some View {
        VStack {
            HStack {
                Text("Pokedex")
                    .font(.system(size: 50))
                    .bold()
                    .padding(.bottom, -17.0)
                
                Spacer()
                
                NavigationLink(destination: FavoriteListView(favoriteVM: favoriteVM)) {
                    Text("Show Favorites")
                }
            }
            
            Spacer()

            List {
                ForEach(pokedexVM.pokemonNameAndDetails, id: \.details.id) { pokemon in
                    PokemonRow(pokemonNameAndDetails: pokemon)
                }
            }
            .padding(.top, 30)
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}

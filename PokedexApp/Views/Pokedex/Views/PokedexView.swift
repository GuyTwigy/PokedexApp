//
//  PokedexView.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import SwiftUI

struct PokedexView: View {
    
    @StateObject private var pokedexVM = PokedexVM()
    @EnvironmentObject var favoritesVM: FavoritesVM
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        
                        Text("Pokedex")
                            .font(.system(size: 45))
                            .bold()
                            .padding()
                        
                        Spacer()
                    }
                    .frame(height: 100)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    List {
                        ForEach(pokedexVM.PokemonFullDetailsList, id: \.details.id) { pokemon in
                            PokemonRow(pokemonFullDetails: pokemon)
                                .onAppear {
                                    if pokemon.details.id == pokedexVM.PokemonFullDetailsList.last?.details.id && !pokedexVM.PokemonFullDetailsList.isEmpty {
                                        pokedexVM.loadMoreDataIfNeeded()
                                    }
                                }
                        }
                    }
                    .padding(.top, -15)
                }
                if pokedexVM.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2.5)
                        .padding()
                }
            }
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
            .environmentObject(FavoritesVM())
    }
}

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
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text("Pokedex")
                    .font(.system(size: 45))
                    .bold()
                    .padding(.bottom, -30.0)
                
                Spacer()
                
                NavigationLink(destination: FavoriteListView()
                    .environmentObject(favoriteVM)) {
                        VStack {
                            Spacer()
                            
                            Text("Tap To Check Yours Favorites Pokemons")
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .minimumScaleFactor(0.5)
                            
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10, height: 10)
                                .foregroundColor(.red)
                        }
                        .padding(.top, -100.0)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 1)
                        )
                    }
                    .padding()
            }
            .frame(height: 100)
            .padding(.top, 20)
            
            Spacer()
            
            List {
                ForEach(pokedexVM.PokemonFullDetailsList, id: \.details.id) { pokemon in
                    PokemonRow(pokemonFullDetails: pokemon)
                        .onAppear {
                            if pokedexVM.counterForFetchMore < 70 && !pokedexVM.isLoading || pokemon.details.id == pokedexVM.PokemonFullDetailsList.last?.details.id {
                                pokedexVM.loadMoreDataIfNeeded()
                            }
                        }
                }
            }
            .padding(.top, 30)
            
            if pokedexVM.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}

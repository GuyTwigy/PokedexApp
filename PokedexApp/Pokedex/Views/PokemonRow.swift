//
//  PokemonRow.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import SwiftUI

struct PokemonRow: View {
    
    enum RowState {
        case pokedex
        case favorite
    }
    
    var pokemonFullDetails: PokemonFullDetails
    
    @State private var navigateToDetails = false
    @ObservedObject private var fetchImageUrl: FetchImageUrl
    @State private var isLikeTapped: Bool
    @EnvironmentObject var favoriteVM: FavoriteVM
    
    init(pokemonFullDetails: PokemonFullDetails) {
        self.pokemonFullDetails = pokemonFullDetails
        self.isLikeTapped = pokemonFullDetails.isFav
        fetchImageUrl = FetchImageUrl(imageUrl: pokemonFullDetails.details.sprites?.frontDefault ?? "")
    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination: PokemonDetailsView(pokemon: pokemonFullDetails), isActive: $navigateToDetails) {
                EmptyView()
            }
            .hidden()
            
            HStack {
                if fetchImageUrl.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    AsyncImage(url: URL(string: pokemonFullDetails.details.sprites?.frontDefault ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(12)
                                .padding(.bottom, 10)
                                .shadow(radius: 5, x: 3, y: 5)
                        case .failure:
                            Text("Unable to load image.")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                Spacer()
                
                Text(pokemonFullDetails.nameAndUrl.name ?? "")
                    .font(.system(size: 20))
                    .bold()
                    .padding(.trailing, 20.0)
                
                
                Spacer()
                
                Button(action: {
                    isLikeTapped.toggle()
                    favoriteVM.toggleFavorite(pokemon: pokemonFullDetails, isFavorite: isLikeTapped)
                }) {
                    if isLikeTapped {
                        Image(systemName: "heart.fill")
                            .padding(15)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 2)
                                    .background(.red)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    } else {
                        Image(systemName: "heart")
                            .padding(15)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 2)
                                    .background(.white)
                            )
                            .foregroundColor(.gray)
                            .cornerRadius(10)
                    }
                }
                .padding(.trailing, 20.0)
                .buttonStyle(PlainButtonStyle())
            }
            .contentShape(Rectangle()) // Make sure the entire area of HStack is tappable
            .onTapGesture {
                navigateToDetails = true
            }
        }
        .listRowSeparator(.hidden)
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(pokemonFullDetails:
                    PokemonFullDetails(nameAndUrl: NameAndUrlData(name: "guy", url: "twig"), details: PokemonData(id: 1, moves: [PokemonMovesData(move: NameAndUrlData(name: "guy", url: "twig"))], abilities: [PokemonAbilitiesData(ability: NameAndUrlData(name: "guy", url: "twig"))], stats: [PokemonStatsData(stat: NameAndUrlData(name: "guy", url: "twig"))], sprites: SpritesData(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")), isFav: true))
    }
}

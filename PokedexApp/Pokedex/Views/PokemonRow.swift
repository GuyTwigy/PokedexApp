//
//  PokemonRow.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import SwiftUI

struct PokemonRow: View {
    
    var pokemonNameAndDetails: (nameAndUrl: NameAndUrlData, details: PokemonData, isFav: Bool)
    
    @ObservedObject private var fetchImageUrl: FetchImageUrl
    @State private var isLikeTapped: Bool
    @EnvironmentObject var favoriteVM: FavoriteVM
    
    init(pokemonNameAndDetails: (nameAndUrl: NameAndUrlData, details: PokemonData, isFav: Bool)) {
        self.pokemonNameAndDetails = pokemonNameAndDetails
        self.isLikeTapped = pokemonNameAndDetails.isFav
        fetchImageUrl = FetchImageUrl(imageUrl: pokemonNameAndDetails.details.sprites?.frontDefault ?? "")
    }
    
    var body: some View {
        HStack {
            
            if fetchImageUrl.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                AsyncImage(url: URL(string: pokemonNameAndDetails.details.sprites?.frontDefault ?? "")) { phase in
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
            
            Text(pokemonNameAndDetails.nameAndUrl.name ?? "")
                .font(.system(size: 20))
                .bold()
                .padding(.trailing, 20.0)
            
            
            Spacer()
            
            Button(action: {
                isLikeTapped.toggle()
                if isLikeTapped {
                    favoriteVM.addFavorite(pokemonNameAndDetails)
                } else {
                    favoriteVM.removeFavorite(pokemonNameAndDetails)
                }
            }) {
                if isLikeTapped {
                    Image(systemName: "heart.fill")
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 2)
                                .background(.red)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                } else {
                    Image(systemName: "heart")
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                                .background(Color.white)
                        )
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                }
            }
            .padding(.trailing, 20.0)
        }
        .listRowSeparator(.hidden)
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(pokemonNameAndDetails: (nameAndUrl: NameAndUrlData(name: "guy", url: "twig"), details: PokemonData(id: 1, moves: [PokemonMovesData(move: NameAndUrlData(name: "guy", url: "twig"))], stats: [PokemonStatsData(stat: NameAndUrlData(name: "guy", url: "twig"))], sprites: SpritesData(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")), isFav: true))
    }
}

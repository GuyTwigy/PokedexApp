//
//  PokemonFavRow.swift
//  PokedexApp
//
//  Created by Guy Twig on 31/01/2024.
//

import SwiftUI

struct PokemonFavRow: View {
    
    var pokemonFullDetails: PokemonFullDetails
    @ObservedObject private var fetchImageUrl: FetchImageUrl
    @EnvironmentObject var favoriteVM: FavoriteVM
    
    init(pokemonFullDetails: PokemonFullDetails) {
        self.pokemonFullDetails = pokemonFullDetails
        fetchImageUrl = FetchImageUrl(imageUrl: pokemonFullDetails.details.sprites?.frontDefault ?? "")
    }
    
    var body: some View {
        HStack {
            Text(pokemonFullDetails.nameAndUrl.name ?? "")
                .font(.system(size: 30))
                .bold()
                .padding(.leading, 30.0)
            
            Spacer()
            
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
                            .padding(.trailing, 20.0)
                            .shadow(radius: 5, x: 3, y: 5)
                    case .failure:
                        Text("Unable to load image.")
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}

struct PokemonFavRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonFavRow(pokemonFullDetails:
                        PokemonFullDetails(nameAndUrl: NameAndUrlData(name: "guy", url: "twig"), details: PokemonData(id: 1, moves: [PokemonMovesData(move: NameAndUrlData(name: "guy", url: "twig"))], abilities: [PokemonAbilitiesData(ability: NameAndUrlData(name: "guy", url: "twig"))], stats: [PokemonStatsData(stat: NameAndUrlData(name: "guy", url: "twig"))], sprites: SpritesData(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")), isFav: true))
    }
}

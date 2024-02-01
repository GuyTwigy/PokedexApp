//
//  PokemonDetailsView.swift
//  PokedexApp
//
//  Created by Guy Twig on 31/01/2024.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    var pokemonFullDetails: PokemonFullDetails
    @ObservedObject private var fetchImageUrl: FetchImageUrl
    @EnvironmentObject var favoritesVM: FavoritesVM
    @State var isLikeTapped: Bool
    
    init(pokemonFullDetails: PokemonFullDetails) {
        self.pokemonFullDetails = pokemonFullDetails
        isLikeTapped = PokedexManager.sharedInstance.favoritesList.contains(where: { $0.details.id == pokemonFullDetails.details.id })
        fetchImageUrl = FetchImageUrl(imageUrl: pokemonFullDetails.details.sprites?.frontDefault ?? "")
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(pokemonFullDetails.nameAndUrl.name ?? "")
                    .font(.system(size: 25))
                    .padding()
                    .bold()
                
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
                                .padding(.trailing, 10.0)
                                .shadow(radius: 5, x: 3, y: 5)
                        case .failure:
                            Text("Unable to load image.")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                Button(action: {
                    isLikeTapped.toggle()
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
                .padding()
            }
        }
        .onDisappear {
            favoritesVM.toggleFavorite(pokemon: pokemonFullDetails, isFavorite: isLikeTapped)
        }
        
        
        HStack {
            VStack {
                Text("Moves")
                    .font(.system(size: 20))
                    .padding()
                    .bold()
                List {
                    ForEach(pokemonFullDetails.details.moves ?? [], id: \.move?.name) { moves in
                        DetailsDescriptionRow(textDescription: moves.move?.name ?? "")
                    }
                }
                .padding([.horizontal, .leading], -10)
                .clipped()
            }
            
            VStack {
                Text("Abilities")
                    .font(.system(size: 20))
                    .padding()
                    .bold()
                List {
                    ForEach(pokemonFullDetails.details.abilities ?? [], id: \.ability?.name) { abilities in
                        DetailsDescriptionRow(textDescription: abilities.ability?.name ?? "")
                    }
                }
                .padding([.horizontal, .leading], -10)
                .clipped()
            }
            
            VStack {
                Text("Stats")
                    .font(.system(size: 20))
                    .padding()
                    .bold()
                List {
                    ForEach(pokemonFullDetails.details.stats ?? [], id: \.stat?.name) { stats in
                        DetailsDescriptionRow(textDescription: stats.stat?.name ?? "")
                    }
                }
                .padding([.horizontal, .leading], -10)
                .clipped()
            }
        }
        
        Spacer()
        
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(pokemonFullDetails: PokemonFullDetails(nameAndUrl: NameAndUrlData(name: "guy", url: "twig"), details: PokemonData(id: 1, moves: [PokemonMovesData(move: NameAndUrlData(name: "guy", url: "twig"))], abilities: [PokemonAbilitiesData(ability: NameAndUrlData(name: "guy", url: "twig"))], stats: [PokemonStatsData(stat: NameAndUrlData(name: "guy", url: "twig"))], sprites: SpritesData(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")), isFav: true))
    }
}

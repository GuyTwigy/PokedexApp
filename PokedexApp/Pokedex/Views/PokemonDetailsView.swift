//
//  PokemonDetailsView.swift
//  PokedexApp
//
//  Created by Guy Twig on 31/01/2024.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    var pokemon: PokemonFullDetails
    @EnvironmentObject var favoriteVM: FavoriteVM
    
    var body: some View {
        Text(pokemon.nameAndUrl.name ?? "")
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(pokemon: PokemonFullDetails(nameAndUrl: NameAndUrlData(name: "guy", url: "twig"), details: PokemonData(id: 1, moves: [PokemonMovesData(move: NameAndUrlData(name: "guy", url: "twig"))], abilities: [PokemonAbilitiesData(ability: NameAndUrlData(name: "guy", url: "twig"))], stats: [PokemonStatsData(stat: NameAndUrlData(name: "guy", url: "twig"))], sprites: SpritesData(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")), isFav: true))
    }
}

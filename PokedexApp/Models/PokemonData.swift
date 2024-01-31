//
//  PokemonData.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import Foundation


struct PokemonData: Codable, Identifiable {
    let id: Int?
    let moves: [PokemonMovesData]?
    let abilities: [PokemonAbilitiesData]?
    let stats: [PokemonStatsData]?
    let sprites: SpritesData?
    
    init(id: Int?, moves: [PokemonMovesData]?, abilities: [PokemonAbilitiesData]?, stats: [PokemonStatsData]?, sprites: SpritesData?) {
        self.id = id
        self.moves = moves
        self.abilities = abilities
        self.stats = stats
        self.sprites = sprites
    }
}

struct PokemonMovesData: Codable {
    let move: NameAndUrlData?
    
    init(move: NameAndUrlData?) {
        self.move = move
    }
}

struct PokemonAbilitiesData: Codable {
    let ability: NameAndUrlData?
    
    init(ability: NameAndUrlData?) {
        self.ability = ability
    }
}


struct PokemonStatsData: Codable {
    let stat: NameAndUrlData?
    
    init(stat: NameAndUrlData?) {
        self.stat = stat
    }
}

struct SpritesData: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    init(frontDefault: String?) {
        self.frontDefault = frontDefault
    }
}

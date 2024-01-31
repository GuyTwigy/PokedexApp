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
    let stats: [PokemonStatsData]?
    let sprites: SpritesData?
    
    init(id: Int?, moves: [PokemonMovesData]?, stats: [PokemonStatsData]?, sprites: SpritesData?) {
        self.id = id
        self.moves = moves
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

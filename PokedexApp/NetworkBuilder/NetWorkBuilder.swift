//
//  NetWorkBuilder.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import Foundation

class NetworkBuilder {
    
    enum ApiUrls {
        case pokedexBaseUrl
        
        var description: String {
            switch self {
            case .pokedexBaseUrl:
                return "https://pokeapi.co/api/v2/pokemon/"
            }
        }
    }
}

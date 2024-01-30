//
//  PokedexData.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import Foundation

struct PokedexData: Codable {
    let next: String?
    let previous: String?
    let results: [NameAndUrlData]?
}


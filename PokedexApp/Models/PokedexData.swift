//
//  PokedexData.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import Foundation

struct PokedexData: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [NameAndUrlData]?
    
    init(count: Int?, next: String?, previous: String?, results: [NameAndUrlData]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}


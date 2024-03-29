//
//  NameAndUrlData.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import Foundation

struct NameAndUrlData: Codable {
    let name: String?
    let url: String?
    
    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

//
//  PokedexApp.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import SwiftUI

@main
struct PokedexApp: App {
    
    @StateObject var favoriteVM = FavoriteVM()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PokedexView()
                    .environmentObject(favoriteVM)
            }
        }
    }
}

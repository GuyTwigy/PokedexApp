//
//  PokedexApp.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import SwiftUI

@main
struct PokedexApp: App {
    
    @StateObject var favoritesVM = FavoritesVM()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                
                NavigationView {
                    PokedexView()
                        .environmentObject(favoritesVM)
                        .tabItem {
                            Image(systemName: "note")
                            Text("Pokedex")
                        }
                }
                
                NavigationView {
                    FavoritesView()
                        .environmentObject(favoritesVM)
                        .tabItem {
                            Image(systemName: "heart")
                            Text("Favorites")
                        }
                }
            }
        }
    }
}

struct Previews_PokedexApp_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            
            NavigationView {
                PokedexView()
                    .environmentObject(FavoritesVM())
                    .tabItem {
                        Image(systemName: "note")
                        Text("Pokedex")
                    }
            }
            
            NavigationView {
                FavoritesView()
                    .environmentObject(FavoritesVM())
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
            }
        }
    }
}

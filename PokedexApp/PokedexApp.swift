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
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        // Apply the appearance to all tab bars
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                PokedexView()
                    .environmentObject(favoritesVM)
                    .tabItem {
                        Image(systemName: "hare.fill")
                        Text("Pokedex")
                    }
                
                
                FavoritesView()
                    .environmentObject(favoritesVM)
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                
            }
            .accentColor(.orange)
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

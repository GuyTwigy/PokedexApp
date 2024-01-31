//
//  PokedexVM.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import Foundation
import Combine

class PokedexVM: ObservableObject {
    
    private var pokemonNameList: [NameAndUrlData] = []
    private var pokemonDetailsList: [PokemonData] = []
    private var nameAndDetails: [PokemonFullDetails] = []
    private var cancellables = Set<AnyCancellable>()
    
    @Published var PokemonFullDetailsList: [PokemonFullDetails] = []
    @Published var isLoading: Bool = false
    
    init() {
        fetchPokemonsName(urlString: "\(NetworkBuilder.ApiUrls.pokedexBaseUrl.description)?offset=0&limit=20")
    }
    
    func fetchPokemonsName(urlString: String) {
        isLoading = true
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            NetworkManager.sharedInstance.genericGetCall(url: urlRequest, type: PokedexData.self)
                .sink { completion in
                    if case .failure(let error) = completion {
                        print(ErrorsHandlers.requestError(.other(error)))
                    }
                } receiveValue: { [weak self] pokedexData in
                    guard let self else {
                        return
                    }
                    
                    self.pokemonNameList = pokedexData.results ?? []
                    self.fetchAllPokemonDetails()
                }
                .store(in: &cancellables)
        }
    }
    
    func fetchAllPokemonDetails() {
        Task {
            for pokemonName in pokemonNameList {
                if let pokemonData = await fetchSinglePokemonsDetails(url: pokemonName.url ?? "") {
                    nameAndDetails.append(PokemonFullDetails(nameAndUrl: pokemonName, details: pokemonData, isFav: false))
                }
            }
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                
                self.PokemonFullDetailsList = self.nameAndDetails
            }
        }
    }
    
    func fetchSinglePokemonsDetails(url: String) async -> PokemonData? {
        guard let url = URL(string: url) else {
            return nil
        }
        
        do {
            let pokemonData: PokemonData = try await NetworkManager.sharedInstance.fetchData(from: url)
            return pokemonData
        } catch {
            print(ErrorsHandlers.requestError(.other(error)))
            return nil
        }
    }
    
    func updateFavoriteStatus(for pokemon: PokemonFullDetails) {
        if let index = PokemonFullDetailsList.firstIndex(where: { $0.details.id == pokemon.details.id }) {
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                
                self.PokemonFullDetailsList[index].isFav = pokemon.isFav
            }
        }
    }
}

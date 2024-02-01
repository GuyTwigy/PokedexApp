//
//  PokedexVM.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import Foundation
import Combine

class PokedexVM: ObservableObject {
    
    var pokedexDataPayload: PokedexData?
    var counterForFetchMore: Int = 0
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
        guard !isLoading else {
            return
        }
        
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
                    
                    self.pokedexDataPayload = nil
                    self.pokedexDataPayload = pokedexData
                    self.pokemonNameList = pokedexData.results ?? []
                    self.fetchAllPokemonDetails()
                }
                .store(in: &cancellables)
        }
    }
    
    func fetchAllPokemonDetails() {
        Task {
            nameAndDetails.removeAll()
            for pokemonName in pokemonNameList {
                if let pokemonData = await fetchSinglePokemonsDetails(url: pokemonName.url ?? "") {
                    nameAndDetails.append(PokemonFullDetails(nameAndUrl: pokemonName, details: pokemonData, isFav: false))
                    counterForFetchMore += 1
                }
            }
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                
                self.isLoading = false
                self.PokemonFullDetailsList.append(contentsOf: self.nameAndDetails)
                if self.counterForFetchMore >= 100 {
                    self.counterForFetchMore = 0
                }
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
    
    func loadMoreDataIfNeeded() {
        guard let nextURL = pokedexDataPayload?.next, !isLoading else {
            return
        }
        
        fetchPokemonsName(urlString: nextURL)
    }
}

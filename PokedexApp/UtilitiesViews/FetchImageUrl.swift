//
//  FetchImageUrl.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import Foundation

class FetchImageUrl: ObservableObject {
    
    @Published var data = Data()
    @Published var isLoading = false
    
    init(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        isLoading = true
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self else {
                    return
                }
                
                self.isLoading = false
                if let data {
                    self.data = data
                } else if let error {
                    print(ErrorsHandlers.requestError(.other(error)))
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

//
//  NetworkManager.swift
//  PokedexApp
//
//  Created by Guy Twig on 29/01/2024.
//

import Foundation
import Combine

class NetworkManager {
    
    static let sharedInstance: NetworkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    func genericGetCall<T: Codable>(url: URLRequest, type: T.Type) -> Future<T, Error> {
        var request = url
        request.httpMethod = "GET"
        
        return Future<T, Error> { [weak self] promise in
            guard let self else {
                return promise(.failure(ErrorsHandlers.requestError(.invalidRequest(request))))
            }
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { res in
                    guard let response = res.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                        throw ErrorsHandlers.serverError(.invalidStatusCode("Invalid status code"))
                    }
                    
                    let decoder = JSONDecoder()
                    guard let finalData = try? decoder.decode(T.self, from: res.data) else {
                        throw ErrorsHandlers.requestError(.decodingError("Fail to decode"))
                    }
                    
                    return finalData
                }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(err) = completion {
                        switch err {
                        case let decodingerror as DecodingError:
                            promise(.failure(decodingerror))
                        case let apiError as ErrorsHandlers:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(ErrorsHandlers.requestError(.other("Fail to fetch Data" as! Error))))
                        }
                    }
                }, receiveValue: {
                    promise(.success($0))
                })
                .store(in: &self.cancellables)
        }
    }
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ErrorsHandlers.serverError(.badResponse)
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}


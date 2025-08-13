//
//  NetworkManager.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 29.07.2025.
//

import Foundation

protocol INetworkManager {
    var config: NetworkConfig { get set }
    func fetch <T: Decodable>(_ endpoint: Endpoint, method: NetworkType, type: T.Type) async -> Result<T?, Error>
}

class MainNetworkManager: INetworkManager {
    
    var config = NetworkConfig(defaultHeaders: ["accept": "application/json"])
    
    func fetch<T>(_ endpoint: Endpoint, method: NetworkType, type: T.Type) async -> Result<T?, any Error> where T : Decodable {
       
        guard let url = URL(string: NetworkConfig.baseUrl.absoluteString + endpoint.path) else {
            return .failure(NetworkError.invalidURL)
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.type
        
        config.defaultHeaders.forEach {key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let jwt = TokenProvider.shared.load() {
            request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse, 200...299 ~= http.statusCode else {
                return .failure(NetworkError.statusCode((response as? HTTPURLResponse)?.statusCode ?? -1))
            }
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
            
        } catch {
            return .failure(CustomError.networkError)
        }
        
    }
    
}

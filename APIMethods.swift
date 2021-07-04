//
//  APIMethods.swift
//  
//
//  Created by Fenix Lavon on 7/4/21.
//

import Foundation

final class HTTPHandler {
    private let session = URLSession.shared
    
    func get(endPoint: String, parametrs: [String : String] = [:], completion: @escaping (Result<Data, NetworkError>) -> Void) {
        var components = URLComponents(string: Unsplash.baseURL)
        components?.queryItems = parametrs.compactMap { URLQueryItem(name: $0, value: $1) }
        components?.path = endPoint
        guard let url = components?.url else { completion(.failure(.url)); return }
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get.rawValue
        task(with: request, completion: completion)
    }
    
    func task(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            let result: Result<Data, NetworkError>
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            switch (data, error) {
            case let (.some(data), .none):
                result = .success(data)
            case let (.none, .some(error)):
                result = .failure(NetworkError.networkError(underlyingError: error))
            case (.none, .none),
                 (.some, .some):
                result = .failure(NetworkError.network)
            }
        }
        task.resume()
    }
}

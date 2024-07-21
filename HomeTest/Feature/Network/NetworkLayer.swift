//
//  NetworkLayer.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//

import Foundation

/// HTTP Methods
///
/// - get: GET
/// - post: POST
/// - put: PUT
/// - patch: PATCH
/// - delete: DELETE
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol NetworkManagerProtocol {
    func makeRequest<T: Decodable> (link: String,
                                    httpMethod: HTTPMethod)  async throws -> T 
}
struct NetworkManager: NetworkManagerProtocol {
        
    func makeRequest<T: Decodable> (link: String,
                                    httpMethod: HTTPMethod)  async throws -> T {
        guard let url = URL(string: link) else {
            throw(NetworkError.invalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.requestFailed
            }
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }catch let decodingError as DecodingError {
            throw(NetworkError.decodingFailed(message: decodingError.localizedDescription))
        }catch {
            throw(NetworkError.unknownError(message: error.localizedDescription))
        }
    }
}



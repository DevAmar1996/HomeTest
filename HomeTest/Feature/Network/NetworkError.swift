//
//  NetworkError.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 20/07/2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case decodingFailed
    case unknownError
    
    var errorDescription: String? {
        switch self {
              case .invalidURL:
                  return "The URL is invalid."
              case .requestFailed:
                  return "The request failed."
              case .decodingFailed:
                  return "Failed to decode the response."
              case .unknownError:
                  return "An unknown error occurred."
        }
    }
}

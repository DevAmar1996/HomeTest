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
    case decodingFailed(message: String)
    case unknownError(message: String)
    
    var errorDescription: String? {
        switch self {
              case .invalidURL:
                  return "The URL is invalid."
              case .requestFailed:
                  return "The request failed."
              case .decodingFailed(let message):
                  return "Failed to decode the response. \(message)"
              case .unknownError(let message):
                  return "An unknown error occurred. \(message)"
        }
    }
}



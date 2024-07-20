//
//  ApiListResponse.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 20/07/2024.
//

import Foundation

// MARK: - ApiListResponse
struct ApiListResponse<T: Codable>: Codable {
    let info: Info
    let results: [T]
}

// MARK: - Info
struct Info: Codable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

extension ApiListResponse {
    var haveMorePages: Bool  {
        info.next != nil
    }
}

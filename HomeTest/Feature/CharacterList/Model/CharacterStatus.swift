//
//  CharacterStatus.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//

import SwiftUI

enum CharacterStatus: String, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    
    var color: Color {
        switch self {
        case .alive:
              return .white
        case .dead:
            return .babyBlue
        case .unknown:
            return  .babyPink
        }
    }
    
    var title: String {
        switch self {
        case .alive:
              return "Alive"
        case .dead:
            return "Dead"
        case .unknown:
            return  "Unknown"
        }
    }
}

//
//  CharacterList.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 20/07/2024.
//

import Foundation
//presentable model calss
struct PresentableCharacterList {
    var data: [Character] = []
    var loading: Bool = false
    var error: String? = nil
    var haveMorePages: Bool = false
    
    init(response: ApiListResponse<Character>? = nil, loading: Bool = false, error: String? = nil) {
        self.data = response?.results ?? []
        self.loading = loading
        self.error = error
        self.haveMorePages = response?.haveMorePages ?? false
    }
    
    // Convenience initializer for error
    init(error: String?) {
        self.error = error
        self.loading = false
        self.haveMorePages = false
    }
    
    // Convenience initializer for loading state
    init(loading: Bool) {
        self.loading = loading
        self.haveMorePages = false
    }
}

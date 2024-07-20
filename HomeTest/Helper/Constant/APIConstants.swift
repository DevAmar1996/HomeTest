//
//  APIConstant.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//

import Foundation


struct APIConstants {
    private static let BASEURL =  "https://rickandmortyapi.com"
    
    static func characterApiPath(with page: Int, status: CharacterStatus? = nil) -> String {
        BASEURL + "/api/character/?page=\(page)" + (status == nil ? "" : "&status=\(status?.rawValue ?? "")")
    }
}

//
//  APIConstant.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//

import Foundation


struct APIConstants {
    private static let BASEURL =  "https://rickandmortyapi.com"
    
    static func characterApiPath(status: CharacterStatus? = nil) -> String {
        BASEURL + "/api/character/?page=\(1)" + (status == nil ? "" : "&status=\(status?.rawValue ?? "")")
    }
}

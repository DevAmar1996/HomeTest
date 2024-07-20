//
//  CharacterListViewModel.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//
import Foundation
import Combine

protocol CharacterListViewModelProtocol {
    func loadViewContent()
    func paginate()
    func update(for status: CharacterStatus?)
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    //MARK: Variables
    @Published var shouldShowLoading: Bool = false
    @Published var response: CharacterResponse? = nil
    @Published var haveMorePages: Bool = false
    @Published var apiErrorMessage: String? = nil

        
    //MARK: Logic functions
    func loadViewContent()  {
        loadData()
    }
    
    private func loadData(nextPagePath: String? = nil ,status: CharacterStatus? = nil) {
        shouldShowLoading = nextPagePath == nil
        Task {
            do {
                let link = nextPagePath ?? APIConstants.characterApiPath( status: status)
                let response: CharacterResponse? =  try await NetworkManager.shared.makeRequest(link: link, httpMethod: .get)
                handleResponse(response)
            }catch {
               handleError(error)
            }
        }
    }
    
    private func handleResponse(_ mResponse: CharacterResponse?) {
        if mResponse?.info.prev != nil {
            updateCurrentCharacter(characters: response?.results ?? [])
        }else {
            shouldShowLoading = false
            response = mResponse
        }
        haveMorePages = response?.info.next != nil
    }
    
    private func handleError(_ error: Error) {
          apiErrorMessage = error.localizedDescription
          shouldShowLoading = false
          haveMorePages = false
    }
    
    func updateCurrentCharacter(characters: [Character]) {
        self.response?.results.append(contentsOf: characters)
    }
    
    func paginate() {
        loadData(nextPagePath: response?.info.next)
    }

     func update(for status: CharacterStatus?) {
        loadData(status: status)
    }
}

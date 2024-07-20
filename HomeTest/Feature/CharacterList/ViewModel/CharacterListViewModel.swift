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

    private var page = 1
        
    //MARK: Logic functions
    func loadViewContent()  {
        loadData()
    }
    
 
    private func loadData(status: CharacterStatus? = nil) {
        shouldShowLoading = page == 1
        Task {
            do {
                let link = APIConstants.characterApiPath(with: page, status: status)
                let response: CharacterResponse? =  try await NetworkManager.shared.makeRequest(link: link, httpMethod: .get)
                handleResponse(response)
            }catch {
               handleError(error)
            }
        }
    }
    
    private func handleResponse(_ response: CharacterResponse?) {
        if page > 1 {
            updateCurrentCharacter(characters: response?.results ?? [])
        }else {
            shouldShowLoading = false
            self.response = response
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
        page += 1
        loadData()
    }

     func update(for status: CharacterStatus?) {
        page = 1
        loadData(status: status)
    }
}

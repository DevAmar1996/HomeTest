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
    @Published private(set) var characterList: PresentableCharacterList = PresentableCharacterList()
    var response: ApiListResponse<Character>? = nil
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    //MARK: Logic functions
    func loadViewContent()  {
        loadData()
    }
    
    private func loadData(nextPagePath: String? = nil ,status: CharacterStatus? = nil) {

        Task {
            do {
                let link = nextPagePath ?? APIConstants.characterApiPath( status: status?.rawValue)
                response =  try await networkManager.makeRequest(link: link, httpMethod: .get)
                handleResponse(response)
            }catch {
                handleError(error)
            }
        }
    }
    
    private func handleResponse(_ mResponse: ApiListResponse<Character>?) {
        response = mResponse
        characterList = PresentableCharacterList(response: response,
                                                 loading: false,
                                                 error: nil)
    }
    
    private func handleError(_ error: Error) {
        characterList = PresentableCharacterList(error:
                                        error.localizedDescription)
    }
    
    func paginate() {
        loadData(nextPagePath: response?.info.next)
    }
    
    func update(for status: CharacterStatus?) {
        loadData(status: status)
    }
}

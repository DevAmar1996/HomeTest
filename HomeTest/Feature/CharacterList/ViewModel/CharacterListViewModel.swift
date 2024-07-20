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
//    @Published var shouldShowLoading: Bool = false
    @Published private(set) var characterList: PresentableCharacterList = PresentableCharacterList()
    private var response: ApiListResponse<Character>? = nil
//    @Published var haveMorePages: Bool = false
//    @Published var apiErrorMessage: String? = nil
//    
    //MARK: Logic functions
    func loadViewContent()  {
        loadData()
    }
    
    private func loadData(nextPagePath: String? = nil ,status: CharacterStatus? = nil) {

        Task {
            do {
                let link = nextPagePath ?? APIConstants.characterApiPath( status: status)
                response =  try await NetworkManager.shared.makeRequest(link: link, httpMethod: .get)
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

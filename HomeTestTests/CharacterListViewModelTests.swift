//
//  CharacterListViewModelTests.swift
//  HomeTestTests
//
//  Created by Qamar Al Amassi on 21/07/2024.
//

import XCTest
import Combine
@testable import HomeTest
final class CharacterListViewModelTests: XCTestCase {
    
    var viewModel: CharacterListViewModel!
    var mockNetworkManager: MockNetworkManager!
    var cancellables: Set<AnyCancellable>!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockNetworkManager = MockNetworkManager()
        viewModel = CharacterListViewModel(networkManager: mockNetworkManager)
        cancellables = Set<AnyCancellable>()
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockNetworkManager = nil
        viewModel = nil
        cancellables = nil
        try super.tearDownWithError()
    }
    
    func testLoadViewContent()  {
        let expectation = expectation(description: "Load view content")
        viewModel.$characterList
            .dropFirst() // Ignore the initial value
            .sink { model in
                XCTAssertFalse(model.loading)
                XCTAssertNil(model.error)
                XCTAssertEqual(model.data.count, 3)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadViewContent()
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    func testHandleDecodingFailedError()  {
        let expectation = expectation(description: "Handle decoding failed error")
        let decodingMessage = "Mock data corrupted error"
        let expectedErrorDescription = NetworkError.decodingFailed(message: decodingMessage).errorDescription
        
        
        viewModel.$characterList
            .dropFirst() // Ignore the initial value
            .sink { model in
                XCTAssertFalse(model.loading)
                XCTAssertFalse(model.haveMorePages)
                XCTAssertEqual(model.error, expectedErrorDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        
        
        viewModel.loadViewContent()
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.errorType = .decodingFailed(message: decodingMessage)
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    func testHandleRequestFailedError() {
        let expectation = XCTestExpectation(description: "Handle request failed error")
        
        viewModel.$characterList
            .dropFirst() // Ignore the initial value
            .sink { characterList in
                if !characterList.loading {
                    XCTAssertEqual(characterList.error, NetworkError.requestFailed.errorDescription)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.errorType = .requestFailed
        viewModel.loadViewContent()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
  
      
   
    
}

class MockNetworkManager: NetworkManagerProtocol {
    var shouldReturnError = false
    var errorType: NetworkError?
    var isPaginating = false
    
    
    func makeRequest<T: Decodable>(link: String, httpMethod: HTTPMethod) async throws -> T {
        if shouldReturnError {
            if let error = errorType {
                throw error
            }
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error"])
        }
        if isPaginating {
            return mockPaginatedResponse as! T
        } else {
            return mockResponse as! T
        }
    }
    
    var mockResponse: ApiListResponse<Character> {
        let info = Info(count: 3, pages: 1, next: nil, prev: nil)
        let characters = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: ""),
            Character(id: 2, name: "Morty", status: "Alive", species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: ""),
            Character(id: 3, name: "Summer", status: "Alive", species: "Human", type: "", gender: "Female", origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        ]
        return ApiListResponse(info: info, results: characters)
    }
    
    var mockPaginatedResponse: ApiListResponse<Character> {
        let info = Info(count: 20, pages: 3, next: "https://example.com/page3", prev: "https://example.com/page1")
        let characters = (1...20).map {
            Character(id: $0, name: "Character \($0)", status: "Alive", species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        }
        return ApiListResponse(info: info, results: characters)
    }
}

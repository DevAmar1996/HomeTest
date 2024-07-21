//
//  CharacterListViewIntegrationTests.swift
//  HomeTestTests
//
//  Created by Qamar Al Amassi on 21/07/2024.
//

import XCTest
import Combine
@testable import HomeTest


class CharacterListViewIntegrationTests: XCTestCase {
    var view: CharacterListView!
    var viewModel: CharacterListViewModel!
    
    var networkManager: MockNetworkManager!
    
    var cancellables: Set<AnyCancellable>!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkManager = MockNetworkManager()
        viewModel = CharacterListViewModel(networkManager: networkManager)
        view = CharacterListView(viewModel: viewModel)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
        view = nil
        networkManager = nil
        viewModel = nil
        cancellables = nil
        try super.tearDownWithError()
    }
    
    func testViewLoadingIndicatorApperanceWhileFetching() {
        let expectation = self.expectation(description: "Loading indicator should be visible while fetching data")
        
        viewModel.$characterList
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] model in
                    XCTAssertFalse(self?.view.activityIndicator.isAnimating ?? false)
                    expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadViewContent()
        XCTAssertTrue(self.view.activityIndicator.isAnimating)

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testViewShowsErrorMessageOnAPIFailure() {
        networkManager.shouldReturnError = true
          
          let expectation = self.expectation(description: "View should show an error message on API failure")
          
          viewModel.$characterList
            .receive(on: DispatchQueue.main)
              .dropFirst()
              .sink {  modal in
                  
                  XCTAssertNotNil(modal.error)
                  // Assuming showError method shows an alert, we can check for its existence in the view hierarchy

                  let rootVC = AppRouter.shared.window.rootViewController
                  XCTAssertTrue(rootVC?.presentedViewController is UIAlertController)
                  expectation.fulfill()
              }
              .store(in: &cancellables)
          
          viewModel.loadViewContent()
          
        self.wait(for: [expectation], timeout: 10)
      }
}

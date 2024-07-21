//
//  CharacterListView.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 18/07/2024.
//

import UIKit
import Combine

class CharacterListView: UIView, NibLoadable {

    //MARK: Variable
    let viewModel: CharacterListViewModel
    
    var dataSource: CharactersDataSource = CharactersDataSource()
    
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.characterCell)
            tableView.dataSource = dataSource
            tableView.delegate = dataSource
            tableView.accessibilityIdentifier = "characterTableView"
        }
    }
    
    private let loadingFooterView = LoadingFooterView()
    
    var view: UIView!
    
    
    // MARK: - Initializers
    init(viewModel: CharacterListViewModel = CharacterListViewModel(networkManager: NetworkManager())) {
        
        self.viewModel = viewModel
        super.init(frame: .infinite )
        view = loadViewFromNib()
        setupBinding()
    }
    
    override init(frame: CGRect) {
        self.viewModel = CharacterListViewModel(networkManager: NetworkManager())
        
        super.init(frame: frame)
        setupDataSource()

        commonInit()
    }
    
  
    
    required init?(coder: NSCoder) {
        self.viewModel = CharacterListViewModel(networkManager: NetworkManager())
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        view = loadViewFromNib()
        setupDataSource()
        setupBinding()
        viewModel.loadViewContent()
    }
    
    private func setupDataSource() {
        dataSource.paginate = {[weak self] in
            self?.tableView.tableFooterView = self?.loadingFooterView
            self?.viewModel.paginate()
        }
    }
    
    //MARK: Binding
    private func setupBinding() {
        viewModel.$characterList
            .receive(on: DispatchQueue.main)
            .sink {[weak self] model in
                guard let self = self else {return}
                
                //error
                if let error = model.error {
                   showError(error)
                    return
                }
                
                //data
                let isPagination = dataSource.isLoading
                dataSource.updateCharacters(tableView: tableView, with: model.data)
                
                //Pagination
                dataSource.canPaginate = model.haveMorePages
                dataSource.isLoading = false
                
                //loading
                model.loading ? activityIndicator.startAnimating() :   activityIndicator.stopAnimating()
                
            }
            .store(in: &cancellables)
        
        
    }
    
    // MARK: - Error Handling
    private func showError(_ message: String?) {
        guard let message = message else { return }
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let viewController = AppRouter.shared.window.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: Handle filter part
extension CharacterListView {
    func update(for status: CharacterStatus?) {
        // Update logic based on the status
        viewModel.update(for: status)
    }
}

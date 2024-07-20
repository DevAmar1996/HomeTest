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
    var viewModel: CharacterListViewModel = CharacterListViewModel()
    
    var dataSource: CharactersDataSource = CharactersDataSource()
    
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.characterCell)
            
            tableView.dataSource = dataSource
            tableView.delegate = dataSource
        }
    }
    
    private let loadingFooterView = LoadingFooterView()
    
    var view: UIView!
    
    
    
    //MARK: LIFE CYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
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
        viewModel.$shouldShowLoading
            .receive(on: DispatchQueue.main)
            .sink {[weak self] value in
                value ? self?.activityIndicator.startAnimating() :  self?.activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        viewModel.$response
            .receive(on: DispatchQueue.main)
            .sink {[weak self] model in
                print("Fetch Model data")
                self?.dataSource.characters = model?.results ?? []
                self?.tableView.tableFooterView = UIView()
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$haveMorePages
            .receive(on: DispatchQueue.main)
            .sink {[weak self] value in
                self?.dataSource.canPaginate = value
            }
            .store(in: &cancellables)
        
        viewModel.$apiErrorMessage
            .receive(on: DispatchQueue.main)
            .sink {[weak self] message in
                guard let message = message else {return}
                self?.showError(message)
            }
            .store(in: &cancellables)
        
    }
    
    // MARK: - Error Handling
    private func showError(_ message: String?) {
        guard let message = message else { return }
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let viewController = self.window?.rootViewController {
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

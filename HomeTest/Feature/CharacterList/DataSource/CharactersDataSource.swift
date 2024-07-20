//
//  CharactersDataSource.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//
import UIKit


//MARK: TableView delegate/datasource
class CharactersDataSource: NSObject, UITableViewDataSource, UITableViewDelegate  {
    
    var characters: [Character] = []
    
    var canPaginate: Bool = false
          
    var paginate: (() -> Void)?
    
    var isLoading = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.characterCell) ?? UITableViewCell()
        
        let character = characters[indexPath.row]
        
        let view = UIView.from(swiftUIView: CharacterCellView(character: character))

        
        cell.addSubview(view)
                        
        //add view constraint
        view.fillSuperview()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        114
    }
                
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: .zero) - 1
        if indexPath.row == lastRowIndex {
            if canPaginate, !isLoading {
                buildFooterView(tableView)
            } else {
                tableView.tableFooterView = nil
                tableView.contentInset.bottom = 0
            }
        }
    }
    
    func updateCharacters(tableView: UITableView, with newData: [Character]) {
           if isLoading {
               isLoading = false
               let indexPaths = Array(characters.count...(characters.count + newData.count - 1)).map {
                   IndexPath(item: $0, section: 0)
               }
               characters.append(contentsOf: newData)
               tableView.insertRows(at: indexPaths, with: .automatic)
           } else {
               characters = newData
               tableView.reloadData()
           }
       }
}
extension CharactersDataSource {
    private func buildFooterView(_ tableView: UITableView) {
        let footerView = LoadingFooterView()
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.isHidden = false
        tableView.contentInset.bottom = 50
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.paginate?()
        }
    }
}

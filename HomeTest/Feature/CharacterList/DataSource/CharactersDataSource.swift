//
//  CharactersDataSource.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//
import UIKit


//MARK: TableView delegate/datasource
class CharactersDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var characters: [Character] = []
    
    var canPaginate: Bool = false
          
    var paginate: (() -> Void)?
    
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
        guard canPaginate else {return}
        if indexPath.row == characters.count - 1 { // last cell
            canPaginate = false
            paginate?()
        }
    }
    

}

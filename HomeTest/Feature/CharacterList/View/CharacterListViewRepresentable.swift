//
//  CharacterListViewRepresentable.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 18/07/2024.
//

import SwiftUI

struct CharacterListViewRepresentable: UIViewRepresentable {
     
    @Binding var selectedFilter: CharacterStatus?
    

    func makeUIView(context: Context) -> CharacterListView {
        let view = CharacterListView()
        
        
        
        return view
    }
    
    func updateUIView(_ uiView: CharacterListView, context: Context) {
        uiView.update(for: selectedFilter)
    }
    
   
}

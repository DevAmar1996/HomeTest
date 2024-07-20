//
//  MainScreen.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 18/07/2024.
//

import SwiftUI

struct MainScreen: View {
    @State var selectedFilter: CharacterStatus?
  
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,
                   spacing: 8) {
                FilterView(selectedFilter: $selectedFilter)
                
                CharacterListViewRepresentable(selectedFilter: $selectedFilter)
                    
            }.padding([.top, .horizontal], 12)          .navigationBarTitle("Characters", displayMode: .large)

        }
        
    }
}

#Preview {
    MainScreen()
}

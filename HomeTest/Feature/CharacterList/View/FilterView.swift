//
//  FilterView.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 18/07/2024.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var selectedFilter: CharacterStatus?
    var filters = CharacterStatus.allCases 
    
    var body: some View {
        HStack {
            ForEach(filters, id: \.self) { filter in
                Text(filter.title)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Capsule()
                        .stroke(Color.gray, lineWidth: 1)
                        .background(Capsule().fill(selectedFilter == filter ? Color.lightGray : Color.clear)))
                    .onTapGesture {
                        if selectedFilter == filter {
                            selectedFilter = nil
                        }else {
                            selectedFilter = filter
                        }
                    }
            }
        }
    }
}

#Preview {
    FilterView(selectedFilter: .constant(nil))
}

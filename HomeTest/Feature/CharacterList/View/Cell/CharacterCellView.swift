//
//  CharacterCellView.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 18/07/2024.
//

import SwiftUI

struct CharacterCellView: View {
    var character: Character

    var body: some View {
        NavigationLink(destination: CharacterDetailView(character: character)) {
            HStack(alignment: .top, spacing: 16) {
                NetworkImage(imagePath: character.image, width: 75, heigh: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading,spacing: 2){
                    Text(character.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black)
                    
                    Text(character.species)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundStyle(Color.gray)
                }
                Spacer()
            }
            .padding([ .vertical, .horizontal], 16)
            .background(backgroundView)
            .padding(.horizontal, 2)
            .frame(height:  96)
        }       


    }
    
    private var backgroundView: some View {
          RoundedRectangle(cornerRadius: 16)
              .stroke(Color.gray, lineWidth: 1)
              .background((CharacterStatus(rawValue: character.status)?.color ?? Color.clear).opacity(0.3))
              .cornerRadius(16)
      }
    
}

#Preview {
    CharacterCellView(character: .mock)
}


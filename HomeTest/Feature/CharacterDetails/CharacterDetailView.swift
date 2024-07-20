//
//  CharacterDetailView.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    var character: Character
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var namespace: Namespace.ID

    
    var body: some View {
        GeometryReader {geometry in
            VStack(alignment: .leading, spacing: 8){
                ZStack(alignment: .topLeading) {
                    NetworkImage(imagePath: character.image, width: geometry.size.width, heigh: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .matchedGeometryEffect(id: character.id, in: namespace)
                    Button {
                        withAnimation {
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(12)
                            .background(Circle().fill(Color.white))
                            .shadow(color: Color.gray,radius: 8)
                            .padding(.top, geometry.safeAreaInsets.top)
                            .padding(.leading, 20)
                    }
                }
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading,spacing: 4){
                        Text(character.name)
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 4) {
                            Text(character.species + " • ")
                                .font(.title2)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                            
                            Text(character.gender)
                                .font(.title2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    if let characterStatus = CharacterStatus(rawValue: character.status) {
                        Text(characterStatus.title)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Capsule().fill(Color.babyBlue
                                                      ))
                    }
                }.padding()
                Text("Location: \(character.location.name)")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .padding(.leading)
                
            }
            .ignoresSafeArea()
        }.navigationBarHidden(true)
    }

}

#Preview {
    @Namespace var namespace

    return CharacterDetailView(character: .mock, namespace: namespace)
}

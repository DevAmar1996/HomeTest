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
                        .accessibilityIdentifier("characterImage")
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
                    .accessibilityIdentifier("backButton")
                }
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading,spacing: 4){
                        Text(character.name)
                            .font(.title)
                            .fontWeight(.semibold)
                            .accessibilityIdentifier("characterName")

                        HStack(spacing: 4) {
                            Text(character.species + " • ")
                                .font(.title2)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                                .accessibilityIdentifier("characterSpecies")

                            Text(character.gender)
                                .font(.title2)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                                .accessibilityIdentifier("characterGender")

                            
                        }
                    }
                    Spacer()
                    if let characterStatus = CharacterStatus(rawValue: character.status) {
                        Text(characterStatus.title)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Capsule().fill(Color.babyBlue
                                                      ))
                            .accessibilityIdentifier("characterStatus")

                    }
                }.padding()
                Text("Location: \(character.location.name)")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .padding(.leading)
                    .accessibilityIdentifier("characterLocation")

            }
            .ignoresSafeArea()
        }.navigationBarHidden(true)
            .accessibilityIdentifier("CharacterDetailView")

    }

}

#Preview {
    @Namespace var namespace

    return CharacterDetailView(character: .mock, namespace: namespace)
}

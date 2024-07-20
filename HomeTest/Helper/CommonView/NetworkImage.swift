//
//  NetworkImage.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 19/07/2024.
//

import SwiftUI

struct NetworkImage: View {
    var imagePath: String
    var width: CGFloat
    var heigh: CGFloat
    var body: some View {
        AsyncImage(url: URL(string: imagePath)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)             .frame(width: width, height: heigh)
               
        } placeholder: {
            ProgressView()
        }
        .frame(width: width, height: heigh)
    }
}

#Preview {
    NetworkImage(imagePath: "https://images.unsplash.com/photo-1575936123452-b67c3203c357?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", width: 100, heigh: 100)
}

//
//  LikeButton.swift
//  ReadingBooks
//
//  Created by Begum Unal on 2.10.2022.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSetFav: Bool

    var body: some View {
        Button {
            isSetFav.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSetFav ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSetFav ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSetFav: .constant(true))
    }
}

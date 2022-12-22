//
//  LikeButton.swift
//  ReadingBooks
//
//  Created by Begum Unal on 2.10.2022.
//

import SwiftUI

struct LikeButton: View {
    @Binding var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle like", systemImage: isSet ? "heart.fill" : "heart")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .red : .gray)
        }
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(isSet: .constant(true))
    }
}

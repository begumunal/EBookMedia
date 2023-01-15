//
//  LikesView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 29.09.2022.
//

import SwiftUI

struct LikesView: View {
    
    @ObservedObject var books = GetData()
    var body: some View {
        NavigationView{
            List{
                Section("likes"){
                    
                }
            }
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView()
    }
}

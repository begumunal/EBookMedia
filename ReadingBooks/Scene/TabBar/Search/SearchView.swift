//
//  SearchView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 6.12.2022.
//

import SwiftUI

struct SearchView: View {
    @State var searchText : String = ""
    @State var isSearching = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    TextField("search", text: $searchText)
                        .padding(.leading,20)
                }.padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(6.0)
                    .padding(.horizontal)
                    .onTapGesture {
                        self.isSearching = true
                    }
                    .overlay(
                    
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            Button(action: {self.searchText = ""}, label: {Image(systemName: "xmark.circle.fill")})
                            
                        }.padding(.horizontal,32)
                            .foregroundColor(.gray)
                    )
                
                Spacer()
            }
            
        }
       
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

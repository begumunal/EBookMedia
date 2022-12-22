//
//  BookCellView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 29.09.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookCellView: View {
    @ObservedObject var books = GetData()
    
    var body: some View {
        HStack{
            if books.imurl != ""{
                WebImage(url: URL(string: books.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10)
            }
            else{
                Image(systemName: "defaultBookImage").frame(width: 120, height: 170).cornerRadius(10)
            }
            VStack(alignment: .leading, spacing: 10){
                Text(books.title).bold().foregroundColor(.mainPurple)
                Text(books.author)
                Text(books.desc).font(.caption).lineLimit(4)
            }
        }.swipeActions{
            Button(action: {self.readClicked.toggle()}, label: {Text("read").foregroundColor(.mainPurple)})
        }
        
    }
}

struct BookCellView_Previews: PreviewProvider {
    static var previews: some View {
        BookCellView()
    }
}

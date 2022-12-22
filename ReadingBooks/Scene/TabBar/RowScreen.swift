//
//  RowScreen.swift
//  ReadingBooks
//
//  Created by Begum Unal on 2.10.2022.
//

import SwiftUI

struct RowScreen: View {
    @State private var likeClicked = false
    @State private var likeState = false
    @State private var likeButtonColor : Color = .gray
    var body: some View {
        HStack{
            if i.imurl != ""{
                WebImage(url: URL(string: i.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10)
            }
            else{
                Image(systemName: "defaultBookImage").frame(width: 120, height: 170).cornerRadius(10)
            }
            VStack(alignment: .leading, spacing: 10){
                Text(i.title).bold().foregroundColor(.mainPurple)
                Text(i.author)
                Text(i.desc).font(.caption).lineLimit(4)
            }
            Button(action: {self.likeClicked = true
                self.likeState.toggle()
                if self.likeClicked{
                    if likeState{
                        likeButtonColor = .red
                    }else{
                        likeButtonColor = .gray
                    }
                    
                    // veri beğenilenler kısmına aktarılacak
                }
            }, label: {Image(systemName: "suit.heart.fill").foregroundColor(self.likeButtonColor)})
            
            
            
        }.swipeActions{
            Button(action: {self.readClicked.toggle()}, label: {Text("read").foregroundColor(.mainPurple)})
        }
    }
}

struct RowScreen_Previews: PreviewProvider {
    static var previews: some View {
        RowScreen()
    }
}

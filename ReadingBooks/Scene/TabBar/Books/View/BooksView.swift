//
//  BooksView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 25.09.2022.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
struct BooksView: View {
    
    @ObservedObject var getData = GetData()
    @State var addItemButtonIsActive : Bool = false
    @State private var showingProfile = false
    @State private var showingLikes = false
    @State private var readClicked = false
    @State private var isLike = false
    @State private var isFavorite = false
    @State private var likeState = false
    @State private var likeButtonColor : Color = .gray
    @State var readingController = ReadingController()
    @State var bookDatabaseController = BookDatabaseController()
    @State var readBook = false
    @State var url : String = ""
    //var book :Book
    /*var bookIndex : Int{
        getData.data.firstIndex(where: { $0.id == book.id })!
    }*/
    var body: some View {
        
        NavigationView{
            
                List(getData.data){i in
                    //self.isLike = i.likeClicked
                    HStack{
                        if i.imurl != ""{
                            WebImage(url: URL(string: i.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10)
                        }
                        else{
                            Image(systemName: "").frame(width: 120, height: 170).cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 10){
                            Text(i.title).bold().foregroundColor(.mainPurple)
                            //Text(i.author)
                            Text(i.desc).font(.caption).lineLimit(4)
                        }
                    
                        Spacer()
                        VStack {
                            Spacer()
                            FavoriteButton(isSetFav: $isFavorite)
                            Spacer()
                            //LikeButton(isSet: i.isLike )
                            /*Button {
                                i.isLike.toggle()
                            } label: {
                                Label("Toggle like", systemImage: i.isLike ? "heart.fill" : "heart")
                                    .labelStyle(.iconOnly)
                                    .foregroundColor(i.isLike ? .red : .gray)
                            }*/
                            Spacer()
                        }
                        
                        
                    }.swipeActions{
                        
                        Button(action: {
                            self.readClicked = true
                            if readClicked{
                                if self.readBook{
                                    print("allahımmmmmmmm sabırrrrrrrrrr")
                        
                                    
                                    bookDatabaseController.saveReadingBook( bookId: i.id, bookName: i.title, url: i.url)
                                    //ReadingView(url: self.url)
                                }
                                print(i.url)
                                url = i.url
                                self.readBook = true
                            }
                        }, label: {Text("read").foregroundColor(.mainPurple)})
                    }.onTapGesture {
                        
                    }/*.sheet(isPresented: self.$readBook){
                        ReadingView(url: self.url)
                    }*/
                    
                }.navigationTitle("books")
                    .foregroundColor(.mainPurple)
            //TOOLBAR İLE DE YAPABİLECEĞİM KISIM
                .navigationBarItems( trailing:
                    HStack{
                    NavigationLink(destination: LikesView(), label: {
                       Image(systemName: "heart.fill").foregroundColor(.red)})
                    NavigationLink(destination: MessageView(), label: {
                       Image(systemName: "bubble.left.and.bubble.right.fill").foregroundColor(.mainPurple)})
                    }
                   
                )
                .navigationBarTitleDisplayMode(.automatic)
                
        }.navigationBarBackButtonHidden(true)

    }
  
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {

        BooksView()
            
    }
}

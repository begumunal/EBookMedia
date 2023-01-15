//
//  HomePageView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 22.09.2022.
//

import SwiftUI

struct HomePageView: View {

    var body: some View {
        NavigationView{
            TabView{
                BooksView().tabItem{
                    HStack{
                        Image(systemName: "books.vertical.fill")
                        Text("books")
                    }
                }
                
                ReadingView().tabItem{
                    HStack{
                        Image(systemName: "book.circle")
                        Text("reading")
                    }
                }
                SearchView(names: [], surenames: [], emails: [], ids: []).tabItem{
                    HStack{
                        Image(systemName: "magnifyingglass")
                            
                    }
                }
                
                ReadedView().tabItem{
                    HStack{
                        Image(systemName: "book.closed.fill")
                        Text("readed")
                    }
                }
                ProfileView().tabItem{
                    HStack{
                        Image(systemName: "person.fill")
                        Text("profile")
                    }
                }
                
            }.accentColor(.mainPurple)
        }.navigationBarBackButtonHidden(true)
        
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

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
    @State var isGoProfile = false
    var names : [String]
    var surenames : [String]
    var emails : [String]
    var ids : [String]
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    
                    TextField("search", text: $searchText, onCommit: {isSearching = true})
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
                
                List{
                    VStack {
                        HStack{
                            Image(systemName: "eyes").padding()
                            VStack{
                                
                                Text("Admin Admin")
                                    .background(Color.white)
                                    
                                Text("admin1@gmail.com")
                                    .bold()
                                    .background(Color.white)
                                    
                            }
                            Spacer()
                            Button(action: {
                                self.isGoProfile = true
                                
                            }, label: {Image(systemName: "")})
                            NavigationLink( destination: OtherProfileView(userId: "cv9MUSCLXrYbH1trpmUzQldKRyn2",userName: "Admin", userSurename: "Admin"), isActive: $isGoProfile){EmptyView()}
                            
                        }
                        
                    }
                  
                    if isSearching{
                        ForEach(0..<names.count) { index in
                            if searchText == names[index]{
                                HStack {
                                    VStack{
                                        Text(names[index]+" "+surenames[index])
                                            .background(Color.black)
                                            .padding()
                                        Text(emails[index])
                                            .bold()
                                            .background(Color.black)
                                            .padding()
                                    }
                                    Button(action: {
                                        //self.isGoProfile = true
                                        
                                    }, label: {Image(systemName: "eyes")})
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
           
        }
    }
    
    func deneme(){
        
    }
}

struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView(names: [], surenames: [], emails: [], ids: [])
    }
}

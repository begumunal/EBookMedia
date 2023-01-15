//
//  ReadedView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 29.09.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

struct ReadedView: View {
    @State var bookNameForLike : [String] = []
    @State var bookNameForDislike : [String] = []
    @State private var selection = 1
    @State var readedController = ReadedController()
    
    
    public init(){
        
        self.getReadedBookForLike()
        self.getReadedBookForDislike()
      
    }
    var body: some View {
        NavigationView{
            HStack{
                VStack{
                   
                    Picker("", selection: $selection){
                        Image(systemName: "hand.thumbsup.fill").tag(0)
                        Image(systemName: "hand.thumbsdown.fill").tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                    
                    if selection == 0{
                        ScrollView{
                            ForEach(self.bookNameForLike, id: \.self){books in
                                HStack{
                                    Text(books)
                                        .bold()
                                        .background(Color.lightShadow)
                                        .padding()
                                        
                                    Spacer()
                                }.overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder()
                                        .foregroundColor(.gray))
                            }
                        }

                    }else if selection == 1{
                        ScrollView{
                            ForEach(bookNameForDislike, id: \.self){books in
                                HStack{
                                    Text(books)
                                        .bold()
                                        .background(Color.lightShadow)
                                        .padding()
                                        
                                    Spacer()
                                }.overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder()
                                        .foregroundColor(.gray))
                                
                            }
                        }
                       
                    }
                    
                    Spacer()
                }
                
            }
            
        }.onAppear{
            self.getReadedBookForLike()
            self.getReadedBookForDislike()
            
        }
        .navigationTitle("readed list")
        .navigationBarTitleDisplayMode(.inline)
    }
   
    func getReadedBookForLike() {
        //okunan ve beğenilen kitap verilerini liste halinde çekiyorum
        let id = Auth.auth().currentUser?.uid
        var ref: DatabaseReference! = Database.database().reference()
        
        ref.child("readedForLike").child(id!).observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                for child in snapshot.children{
                    let childSnapshot = child as! DataSnapshot
                    if childSnapshot.hasChild("bookName"){
                        self.bookNameForLike.append(childSnapshot.childSnapshot(forPath: "bookName").value as! String)
                    }
                }
            }
        })
       
    }
    func getReadedBookForDislike() {
        //okunan ve beğenilmeyen kitap verilerini liste halinde çekiyorum
        let id = Auth.auth().currentUser?.uid
        var ref: DatabaseReference! = Database.database().reference()
        
        ref.child("readedForDislike").child(id!).observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                for child in snapshot.children{
                    let childSnapshot = child as! DataSnapshot
                    if childSnapshot.hasChild("bookName"){
                        self.bookNameForDislike.append(childSnapshot.childSnapshot(forPath: "bookName").value as! String)
                    }
                }
            }
        })
       
    }
    
}

struct ReadedView_Previews: PreviewProvider {
    static var previews: some View {
        ReadedView()
    }
}

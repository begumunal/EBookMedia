//
//  OtherProfileView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 11.01.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct OtherProfileView: View {
    @State var isFollowing = false
    @State var readedBooks : [String] = []
    @State var followController = FollowController()
    @State var arrayFollowing : [String] = []
    var userId : String
    var userName : String
    var userSurename : String
   
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    //profile image + stats
                    
                    HStack{
                        
                        Image("exampleProfileImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 88,height: 88)
                            .clipShape(Circle())
                        
                        Spacer()
                        
                        HStack(spacing: 32){
                            VStack(spacing: 2){
                                
                                Text("30")//bu kısım veritabanından çekilecek
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("books")
                                    .font(.caption)
                            }
                            
                            VStack(spacing: 2){
                                Text("30")//bu kısım veritabanından çekilecek
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("followers")
                                    .font(.caption)
                            }
                            VStack(spacing: 2){
                                Text("30")//bu kısım veritabanından çekilecek
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("following")
                                    .font(.caption)
                            }
                        }
                        Spacer()
                    }
                    
                    HStack{
                        
                        Text(self.userName + " " + self.userSurename ) //kullanıcının ismi ve soyismi
                        Spacer()
                    }
                    
                    Button(action: {
                        self.isFollowing.toggle()
                         if isFollowing{
                             self.followController.addFollowItem(whoFollowed: self.userId)
                         }else{
                             self.followController.removeFollowItem(whoFollowed: self.userId)
                         }
                        
                    }, label: {
                        Text(isFollowing ? "following" : "follow")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(isFollowing ? .black : .white)
                    }).overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.black)))
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(isFollowing ? Color.green : Color.black)
                        .padding()
                        .tint(isFollowing ? Color.green : Color.black)
                        
                  /*  if isFollowing{
                        self.followController.addFollowItem(whoFollowed: self.userId)
                    }else{
                        self.followController.removeFollowItem(whoFollowed: self.userId)
                    }*/
                    
                   /* NavigationLink( destination: EditProfile(), isActive: $isFollowing){
                        EmptyView()
                    }*/
                    VStack{
                        ForEach(readedBooks, id: \.self){ book in
                            HStack{
                                Text(book)
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
                    
                   // PostCell()
                }
                .padding()
            }
            .navigationTitle("profile")
                .foregroundColor(.mainPurple)
                .font(.caption)
                .navigationBarTitleDisplayMode(.automatic)
            
               
        }.navigationBarBackButtonHidden(false)
            
            .onAppear{
                self.getReadedBooks()
                self.getIsFollowing()
            }
       
    }
    
    func getReadedBooks() {
        //okunan ve beğenilen kitap verilerini liste halinde çekiyorum
       
        var ref: DatabaseReference! = Database.database().reference()
        
        ref.child("readedForLike").child(userId).observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                for child in snapshot.children{
                    let childSnapshot = child as! DataSnapshot
                    if childSnapshot.hasChild("bookName"){
                        self.readedBooks.append(childSnapshot.childSnapshot(forPath: "bookName").value as! String)
                    }
                }
            }
        })
        ref.child("readedForDislike").child(userId).observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                for child in snapshot.children{
                    let childSnapshot = child as! DataSnapshot
                    if childSnapshot.hasChild("bookName"){
                        self.readedBooks.append(childSnapshot.childSnapshot(forPath: "bookName").value as! String)
                    }
                }
            }
        })
    }
   
    func getIsFollowing(){
        var ref: DatabaseReference! = Database.database().reference()
        let followBy = Auth.auth().currentUser!.uid
        ref.child("followers").child(followBy).observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                for child in snapshot.children{
                    let childSnapshot = child as! DataSnapshot
                    if childSnapshot.hasChild("whoFollowed"){
                        self.arrayFollowing.append(childSnapshot.childSnapshot(forPath: "whoFollowed").value as! String)
                    }
                }
            }
        })
        
        for index in arrayFollowing{
            if index == self.userId{
                self.isFollowing = true
            }else{
                self.isFollowing = false
            }
        }
    }
}

struct OtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfileView(userId: "", userName: "", userSurename: "")
    }
}

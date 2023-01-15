//
//  ProfileView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 25.09.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ProfileView: View {

    @State var isShowAlertRemove : Bool = false
    @State var isShowEditProfile : Bool = false
    @State var isShowAlertExit : Bool = false
    @State var exitYes : Bool = false
    @State var userinfo = (id : "", name : "" , username : "")
    @State var readedBooks : [String] = []
    let user = Auth.auth().currentUser
    var ref : DatabaseReference! = Database.database().reference()

    @State var userController = UserController()
    
    init(){
        self.getReadedBooks()
        self.userinfo = self.userController.getUserInformation()
    }
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    //profile image + stats
                    
                    HStack{
                        Spacer()
                        Image("exampleProfileImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 88,height: 88)
                            .clipShape(Circle())
                        
                        Spacer()
                        
                       /* HStack(spacing: 32){
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
                        }*/
                       // Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        Text("\(userinfo.name)" + " " + "\(userinfo.username)" +  "\(self.userController.getUserInformation())") //veritabanından isim ve soyisim bilgileri çekiliyor
                        Spacer()
                    }
                    
                    
                    Button(action: {self.isShowEditProfile = true }, label: {
                        //Benim profilim olduğu için follow ya da unfollow yerine edit profile butonu olmalı.
                        
                        Text("edit profile")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    }).overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.black)))
                    .buttonStyle(.borderedProminent)
                    
                    NavigationLink( destination: EditProfile(), isActive: $isShowEditProfile){
                        EmptyView()
                    }
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
            
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        NavigationLink(destination: BooksView(), label: {
                            Image(systemName: "chevron.backward").foregroundColor(.mainPurple)})
                    }
                   
                    ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing){
                        
                        Menu{
                            Button(action: {
                                self.isShowAlertExit = isTrue(_true: true)!
                            }, label: {
                                Text("log out")
                                Spacer()
                                Image(systemName: "person.fill.xmark")
                            })
                            Button(action: {
                                self.isShowAlertRemove = isTrue(_true: true)!
                            }, label: {
                                Text("remove account")
                                Spacer()
                                Image(systemName: "pip.remove")
                            })
                            
                        }label: {
                            Button {
                          
                            } label: {
                                Label("Toggle like", systemImage: "lightbulb.fill" )
                                .labelStyle(.iconOnly)
                                .foregroundColor(.yellow )}
                        }
                        
                    }
                }
             
        }.navigationBarBackButtonHidden(true)
            .alert("Do you want to remove account?", isPresented: $isShowAlertRemove){
                Button("Yes", role: .destructive){
                    let user = Auth.auth().currentUser
                    user?.delete { error in
                      if let error = error {
                        // An error happened.
                      } else {
                          print("HESAP SİLİNDİ")
                          exit(0)
                        // Account deleted.
                      }
                    }
                }
                Button("No", role: .cancel){
                    
                }
                
            }
            .alert("Do you want to exit?",isPresented: $isShowAlertExit){
                Button("Yes", role: .destructive){
                    self.exitYes = isTrue(_true: true)!
                    //exitApp()
                    //Auth.auth().currentUser = nil
                    
                    exit(0)
                }
                Button("No", role: .cancel){
                    
                }
            }
            .onAppear{
                self.getReadedBooks()
                self.userinfo = self.userController.getUserInformation()
            }
       
    }
    
    func isTrue(_true: Bool) -> Bool? {
        if _true{
            return true
        }else if _true == false {
            return false
        }else{
            return nil
        }
    }
    
    func exitApp(){
        let exit = 1
        assert(exit == 0)
    }
    
    func getReadedBooks() {
        //okunan ve beğenilen kitap verilerini liste halinde çekiyorum
        let id = Auth.auth().currentUser?.uid
        var ref: DatabaseReference! = Database.database().reference()
        
        ref.child("readedForLike").child(id!).observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                for child in snapshot.children{
                    let childSnapshot = child as! DataSnapshot
                    if childSnapshot.hasChild("bookName"){
                        self.readedBooks.append(childSnapshot.childSnapshot(forPath: "bookName").value as! String)
                    }
                }
            }
        })
        ref.child("readedForDislike").child(id!).observe(.value, with: { (snapshot) in
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
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

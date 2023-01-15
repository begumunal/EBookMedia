//
//  UploadPostScreen.swift
//  ReadingBooks
//
//  Created by Begum Unal on 4.11.2022.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct EditProfile: View {
    //@State var postDesc : String = ""
    //@State var image: UIImage?
    //@State var sellectedImage : UIImage = UIImage()
    @State var showPicker = false
    //@State var source : Picker.Source = .library
    @State private var saveEditingInProfile = SaveEditingInProfile()
    @State var user = User(name: "", surename: "", email: "")
    @State private var postModel = PostModel()
    @State var userinfo = (id : "", name : "" , username : "")
    @State var userController = UserController()
    @State var userName = ""
    @State var userSurename = ""
    let userID = Auth.auth().currentUser?.uid
    init(){
        //self.userinfo = self.userController.getUserInformation()
        self.getUserInfo()
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Spacer()
                    
                    Image(uiImage: postModel.image)
                        .resizable()
                        .frame(minWidth: 200,maxWidth: 200,minHeight: 200,maxHeight: 200)
                        .cornerRadius(200.0)
                        .scaledToFit()
                        
                    Button(action: {
                        //self.source = .library
                        self.showPicker = true
                    }, label: {
                        Text("choose image")
                            .fontWeight(.semibold)
                            .foregroundColor(.mainPurple)
                            .padding(.top,1)
                    })
                    
                    TextField("\(self.userName)", text: $user.name)
                        .padding()
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .border(Color.gray)
                        .background(Color(red:239/255,green:245/255,blue:250/255))
                        .cornerRadius(5)
                    TextField("\(self.userSurename)", text: $user.surename)
                        .padding()
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .border(Color.gray)
                        .background(Color(red:239/255,green:245/255,blue:250/255))
                        .cornerRadius(5)
                    
                
                    Button(action: {
                        if user.name != "" && user.surename != ""{
                            self.saveEditingInProfile.savePost(userId: self.userID! ,name: user.name, surename: user.surename , postImage : user.profilePhoto, postId: UUID())
                        }
                        
                    }, label: {
                        Text("save")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            
                    }).overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.black)))
                        .buttonStyle(.borderedProminent)
                        .padding()
                        
                    Spacer()
                }.padding()
                    .sheet(isPresented: $showPicker){
                    
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $postModel.image)
                    }
                    .onAppear{
                        self.getUserInfo()
                    }
            }.padding()
        }
    }
    
    func getUserInfo(){
        let userId = Auth.auth().currentUser?.uid
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("users").child(userId!).observeSingleEvent(of: .value, with: { snapshot in
          // Get user value
          let value = snapshot.value as? NSDictionary
            self.userName = value?["name"] as? String ?? ""
            self.userSurename = value?["surename"] as? String ?? ""

        }) { error in
          print(error.localizedDescription)
        }
    }
    
}

struct UploadPostScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}

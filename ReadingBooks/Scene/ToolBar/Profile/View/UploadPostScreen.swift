//
//  UploadPostScreen.swift
//  ReadingBooks
//
//  Created by Begum Unal on 4.11.2022.
//

import SwiftUI

struct UploadPostScreen: View {
    //@State var postDesc : String = ""
    //@State var image: UIImage?
    //@State var sellectedImage : UIImage = UIImage()
    @State var showPicker = false
    //@State var source : Picker.Source = .library
    @State private var uploadPostController = UploadPostController()
    @State private var postModel = PostModel()
    @State var userinfo = (id : "", name : "" , username : "")
    @State var userController = UserController()
    
    init(){
        self.userinfo = self.userController.getUserInformation()
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Spacer()
                    Image(uiImage: postModel.image)
                        .resizable()
                        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 300,maxHeight: 350)
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
                    ScrollView{
                        TextField("description", text: $postModel.postDescription)
                            .padding()
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .border(Color.gray)
                            .background(Color(red:239/255,green:245/255,blue:250/255))
                            .cornerRadius(5)
                            
                    }.padding()
                    Button(action: {
                        if postModel.postDescription != "" {
                            uploadPostController.savePost(userId: userinfo.id ,postId: UUID(), desc: postModel.postDescription , postImage: postModel.image)
                        }
                        
                    }, label: {
                        Text("send")
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
            }.padding()
        }
    }
}

struct UploadPostScreen_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostScreen()
    }
}

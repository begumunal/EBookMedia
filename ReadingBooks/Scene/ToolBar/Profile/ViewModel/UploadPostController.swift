//
//  UploadPostController.swift
//  ReadingBooks
//
//  Created by Begum Unal on 8.11.2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseStorage
import UIKit
import SwiftUI

//FOTOĞRAFLAR FİREBASE STORAGE A KAYDEDİLME İŞLEMİ 
struct UploadPostController{
    
    mutating func savePost( userId : String, postId : UUID , desc : String , postImage : UIImage){
        var userController = UserController()
        var post = PostModel()
        var date : Date = Date()
        var returnValue = false
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = postImage.jpegData(compressionQuality: 0.5){//fotoğrafı 0.5 oranında sıkıştırmasını sağladık
            let imageReference = mediaFolder.child("\(postId).jpeg")//uzantısı jpeg şeklinde olsun ki verdiği url yi internete yazdığımızda görseli indirebilelim.
            imageReference.putData(data, metadata: nil){(metadata, error) in
                if error != nil{
                    print(error?.localizedDescription)
                    
                }else{
                    imageReference.downloadURL(){(url , error) in
                        if error == nil{
                            let imageurl = url?.absoluteString//url yi string e çevirdim
                            print(imageurl)
                            
                            //realtime
                            var ref : DatabaseReference!
                            ref = Database.database().reference()
                            let postedBy = Auth.auth().currentUser!.email! //post kim tarafından gönderildi bilgisini kullanıcı emailine göre yaptım.
                            
                            ref.child("posts").child("\(postId)").setValue(["imageUrl" : imageurl, "description" : desc, "postedBy" : "\(postedBy)", "likeCount" : post.likeCount])
                    
                        }
                    }
                }
            }
        }
        
    }
}

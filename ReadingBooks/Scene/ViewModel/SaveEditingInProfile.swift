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
class SaveEditingInProfile{
    
     func savePost( userId : String, name : String, surename: String, postImage : UIImage, postId : UUID){
       
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
                           
                            ref.child("users").child("\(userId)").setValue(["imageUrl" : imageurl, "name" : name, "surename" : surename])
                    
                        }
                    }
                }
            }
        }
         
        
        
    }
}

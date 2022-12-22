//
//  SignUpController.swift
//  ReadingBooks
//
//  Created by Begum Unal on 23.09.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SwiftUI
import FirebaseDatabase
import SwiftUI
struct SignUpController {

    //var ref : DatabaseReference!

    func register1(name : String, surename : String, email : String, password : String) -> Bool{
        var showWelcome = false
        if name != "" && surename != ""{
            Auth.auth().createUser(withEmail: email, password: password){result,error in
                if error != nil{
                    print(error!.localizedDescription)
                    //return showWelcome
                }else{
                   
                    showWelcome = true
                    let user = User(name: name, surename: surename)
                    
                    var ref : DatabaseReference!
                    ref = Database.database().reference()
                    let userId = Auth.auth().currentUser?.uid
                    //burada realtime a kaydederkenki id yi authentication a kaydederken aldığı id yi verdim bunun sebebi kullanıcıya ait realtime dan bir veri çekerken hangi id den çektiğim önemli.
                    ref.child("users").child(userId!).setValue(["name" : user.name, "surename" : user.surename])
                    //return true
                }
                
            }
        }
        return showWelcome
       
    }
    
    func login(email : String, password : String) -> Bool{
        var showViewHome = false
        Auth.auth().signIn(withEmail: email, password: password){result,error in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                print("firebase bağlantı sorunu yok.")
                showViewHome = true
                
            }
        }
        return showViewHome
    }

}



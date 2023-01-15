//
//  UserController.swift
//  ReadingBooks
//
//  Created by Begum Unal on 8.11.2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class UserController{
     func getUserInformation() -> (id : String, name : String , username : String){
         
        
        let user = Auth.auth().currentUser
        var ref : DatabaseReference! = Database.database().reference()
        
        var userId : String = ""
        var name : String = ""
        var username : String = ""
        var returnValue = (id : "", name : "" , username : "")
        var userID = Auth.auth().currentUser!.uid

         ref.child("users").child(userID).getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            userId = snapshot?.value as? String ?? "Unknown";
        });
        
         ref.child("users/\(userID)").observeSingleEvent(of: .value, with: { snapshot in
            /*guard error == nil else {
                print(error!.localizedDescription)
                return;
            }*/
            let value = snapshot.value as? NSDictionary
            username = value?["surename"] as? String ?? ""
            //username = snapshot?.value as? String ?? "Unknown";
        });
       
        ref.child("users").child(userID).child("name").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            name = snapshot?.value as? String ?? "Unknown";
        });
        
        returnValue = (id : userId, name : name , username : username)
        print("-----------" + returnValue.username + returnValue.name)
        return returnValue
    }
}

//
//  FollowController.swift
//  ReadingBooks
//
//  Created by Begum Unal on 14.01.2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class FollowController{
    func addFollowItem(whoFollowed : String){
        
        let followBy = Auth.auth().currentUser!.uid
        var ref : DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("followers").child(followBy).child(whoFollowed).setValue(["whoFollowed" : whoFollowed])
    }
    func removeFollowItem(whoFollowed : String){
        let followBy = Auth.auth().currentUser!.uid
        var ref : DatabaseReference!
        ref = Database.database().reference()
        ref.child("followers").child(followBy).child(whoFollowed).removeValue()
    }
}

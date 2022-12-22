//
//  SearchController.swift
//  ReadingBooks
//
//  Created by Begum Unal on 7.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class SearchController{
    
    private let id = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    
    func fetchUser(){
        
        ref = Database.database().reference()
        
        //ref.child("users")
    }
}

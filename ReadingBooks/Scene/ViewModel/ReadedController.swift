//
//  ReadedController.swift
//  ReadingBooks
//
//  Created by Begum Unal on 2.12.2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import SwiftUI

class ReadedController{
    
    private let id = Auth.auth().currentUser?.uid

    
    func saveReadedBookForLike(bookName : String, url : String){
        var id = UUID()
        var ref : DatabaseReference!
        ref = Database.database().reference()
        let readingBy = Auth.auth().currentUser!.email!
        
        ref.child("readedForLike").child(self.id!).child(id.uuidString).setValue(["bookName" : bookName, "readingBy" : readingBy, "bookURL" : url] )
        
    }
    func saveReadedBookForDislike(bookName : String, url : String){
        var id = UUID()
        var ref : DatabaseReference!
        ref = Database.database().reference()
        let readingBy = Auth.auth().currentUser!.email!
        
        ref.child("readedForDislike").child(self.id!).child(id.uuidString).setValue(["bookName" : bookName, "readingBy" : readingBy, "bookURL" : url] )
        
    }
    
    
   
}

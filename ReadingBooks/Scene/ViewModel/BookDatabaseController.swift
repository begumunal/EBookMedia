//
//  BookDatabaseController.swift
//  ReadingBooks
//
//  Created by Begum Unal on 25.11.2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import FirebaseCore

struct BookDatabaseController{
    
    mutating func saveReadingBook( bookId : String , bookName : String, url : String){
        let id = Auth.auth().currentUser?.uid
        var ref : DatabaseReference!
        ref = Database.database().reference()
        let readingBy = Auth.auth().currentUser!.email!
        
        ref.child("reading").child(id!).setValue(["bookId" : bookId, "bookName" : bookName, "readingBy" : readingBy, "bookURL" : url] )
        
    }
    

}

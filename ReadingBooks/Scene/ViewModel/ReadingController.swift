//
//  ReadingController.swift
//  ReadingBooks
//
//  Created by Begum Unal on 22.11.2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class ReadingController{
  
    var isEmpty = true
    var readingBookArray = [String]()
    private var bookName = ""
    private var url = ""
    private var bookDatabaseController = BookDatabaseController()
    private var return_value : [String : String] = ["bookName" :"", "url": ""]
    private let id = Auth.auth().currentUser?.uid
    
    func getReadingBook() -> Dictionary<String, String>{
       
        let readingBookId = Auth.auth().currentUser?.uid
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("reading").child(self.id!).observeSingleEvent(of: .value, with: { snapshot in
          // Get user value
          let value = snapshot.value as? NSDictionary
            self.bookName = value?["bookName"] as? String ?? ""
            self.url = value?["bookURL"] as? String ?? ""

        }) { error in
          print(error.localizedDescription)
        }
        self.return_value["bookName"] = self.bookName
        self.return_value["url"] = self.url
        
        return self.return_value
    }
    
    func removeBook(){
        var ref : DatabaseReference!
        ref = Database.database().reference()
        ref.child("reading").child(self.id!).removeValue()
    }

    
}

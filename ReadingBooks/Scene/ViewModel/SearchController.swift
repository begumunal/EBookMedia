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
import SwiftUI

class SearchController{
  
    static func searchUser(input : String, onSuccess: @escaping(_ user: [SearchUser]) -> Void){
        @State var names : [String] = []
        @State var surenames : [String] = []
        @State var emails : [String] = []
        @State var ids : [String] = []
        let id = Auth.auth().currentUser?.uid
        var ref: DatabaseReference! = Database.database().reference()
        ref.child("users").child(id!).observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                for child in snapshot.children{
                    let childSnapshot = child as! DataSnapshot
                    if childSnapshot.hasChild("name"){
                        names.append( childSnapshot.childSnapshot(forPath: "name").value as! String)
                        surenames.append( childSnapshot.childSnapshot(forPath: "surename").value as! String)
                        emails.append( childSnapshot.childSnapshot(forPath: "email").value as! String)
                        ids.append( childSnapshot.childSnapshot(forPath: "id").value as! String)
                    }
                }
            }
            
        })
        
        SearchView(names: names, surenames : surenames, emails: emails, ids: ids)
    }
    
}


extension String{
    func removeWhiteSpace() ->String{
        return components(separatedBy: .whitespaces).joined()
    }
}

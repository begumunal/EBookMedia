//
//  MainChatView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 14.01.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct MainChatView: View {
    @State var userIDs : [String] = []
    @State private var users : [User] = []
    @State var user = User(name: "", surename: "", email: "")
    @State var mainChatViewController = MainChatViewController()
    init(){
        self.getFollowingUsersId()
    }
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(users) { user in
                    VStack{
                        HStack(spacing: 16){
                            Image(systemName: "exampleProfileImage")
                                .font(.system(size: 32))
                            VStack(alignment: .leading){
                                Text(user.name+" "+user.surename)
                                Text("message send to user")
                            }
                            Spacer()
                        }
                    }
                }
            }
        }.onAppear{
            self.getFollowingUsersId()
        }
    }
    
    func getFollowingUsersId(){
        var ref: DatabaseReference! = Database.database().reference()
        let followBy = Auth.auth().currentUser!.uid
        ref.child("followers").child(followBy).observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                for child in snapshot.children{
                    let childSnapshot = child as! DataSnapshot
                    if childSnapshot.hasChild("whoFollowed"){
                        self.userIDs.append(childSnapshot.childSnapshot(forPath: "whoFollowed").value as! String)
                    }
                }
            }
        })
    }
    func deneme(){
        let Id = Auth.auth().currentUser?.uid
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        /*ForEach(userIDs){ id in
            
            ref.child("users").child(id).observeSingleEvent(of: .value, with: { snapshot in
              // Get user value
              let value = snapshot.value as? NSDictionary
                self.userName = value?["name"] as? String ?? ""
                self.userSurename = value?["surename"] as? String ?? ""

            }) { error in
              print(error.localizedDescription)
            }
        }*/
        
    }
}

struct MainChatView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatView()
    }
}

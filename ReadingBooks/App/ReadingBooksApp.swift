//
//  ReadingBooksApp.swift
//  ReadingBooks
//
//  Created by Begum Unal on 20.09.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ReadingBooksApp: App {
    let persistenceController = PersistenceController.shared

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            //WelcomeView()
               // .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
          if Auth.auth().currentUser != nil{//daha önce giriş yaptıysa
                HomePageView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            else{
                WelcomeView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
        }
    }
}

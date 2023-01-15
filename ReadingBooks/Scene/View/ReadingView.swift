//
//  ReadingView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 29.09.2022.
//

import SwiftUI
import WebKit
import SwiftyJSON
import SDWebImageSwiftUI
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct ReadingView: View {

    //@State var url = ""
    @State var getData = GetData()
    @State var readingBook : String = ""
    @State var get_value : [String : String] = ["bookName" :"", "url": ""]
    @State var bookName : [String] = [""]
    @State var readingController = ReadingController()
    @State var bookDatabaseController = BookDatabaseController()
    @State var url = ""
    @State var showWebView = false
    @State var showAlert = false
    @State var readedController = ReadedController()
    
    init(){
        self.get_value = readingController.getReadingBook()
        self.bookName[0] = self.get_value["bookName"]!
        self.url = self.get_value["url"]!
    }
    var body: some View {
        
        //WebView(url: self.url)
        NavigationView{
            VStack{
                HStack{
                    Text(self.bookName[0] )
                        .padding()
                        .onTapGesture {
                            self.showWebView.toggle()
                        }
                    Button(action: {
                        self.showAlert = true
                 
                    }, label: {
                        self.bookName[0] == "" ? Text("") : Text("done").foregroundColor(.black)
                    }).padding(.all,15)
                        .background(self.bookName[0] == "" ?  Color.white : Color.green)
                        .alert(isPresented: $showAlert){
                            Alert(
                                title: Text("did you like this book?"),
                                message: Text(" "),
                                primaryButton: .destructive(Text("yes")
                                    .bold()
                                    .foregroundColor(Color.blue)){
                                    self.readedController.saveReadedBookForLike(bookName: self.bookName[0], url: self.url)
                                    self.readingController.removeBook()
                                    self.bookName[0] = ""
                                    
                                }, secondaryButton: .destructive(Text("no")
                                    .foregroundColor(Color.blue)){
                                    self.readedController.saveReadedBookForDislike(bookName: self.bookName[0], url: self.url)
                                    self.readingController.removeBook()
                                    self.bookName[0] = ""
                                    }
                               
                            )
                        }
                }
                
                Spacer()
               
            }
            .navigationTitle("reading book right now")
            .navigationBarTitleDisplayMode(.automatic)
            
       
        }
        .onAppear{
           
            self.get_value = readingController.getReadingBook()
            self.bookName[0] = self.get_value["bookName"]!
            self.url = self.get_value["url"]!
        }
        .sheet(isPresented: self.$showWebView){
            WebView(url: self.url)
        }
        
    }
 
}

struct ReadingView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingView()
    }
}

struct WebView : UIViewRepresentable{
    
    var url : String = ""
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        print(url)
        return view
    }
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
    
    
}


//
//  WelcomeView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 20.09.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct WelcomeView: View {
    
    var signUpController = SignUpController()

    @State var geo: CGFloat = 100
    @State var showViewLogin : Bool = false
    @State var showViewHome : Bool = false
    @State var showViewSignUp : Bool = false
    
    @State var email : String = ""
    @State var password : String = ""
    

    init(){
       // self.showViewHome = signUpController.login(email: self.email, password: self.password)
    }
    var body: some View {
        NavigationView{
                VStack(alignment: .center){
                    Spacer()
                    Text("WELCOME")
                        .fontWeight(.semibold)
                        .foregroundColor(.mainPurple)
                    
                    Text("log in to your existant account")
                        .foregroundColor(.gray)
                    
                    TextField("email", text: $email)
                        .padding()
                        .cornerRadius(5)
                        .modifier(InnerShadowViewModifier())
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.bottom, 20)
                    
                    SecureField("password", text: $password)
                        .padding()
                        .cornerRadius(5)
                        .modifier(InnerShadowViewModifier())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.bottom, 20)
                        
                
                    HStack{
                        Spacer()
                        Button(action: {}, label: { Text("foget password?").foregroundColor(.blue)})
                    }.padding(.bottom,20)
                    
                    HStack{
                        //SIGN IN
                        Button(action: {
                           // showViewHome = signUpController.login(email: self.email, password: self.password)
                            Auth.auth().signIn(withEmail: email, password: password){result,error in
                                if error != nil {
                                    print(error!.localizedDescription)
                                }else{
                                    print("firebase bağlantı sorunu yok.")
                                    showViewHome = true
                                    
                                }
                            }
                        }, label: {
                            Spacer()
                            Text("login")
                                .fontWeight(.bold)
                            Spacer()
                        })
                        .foregroundColor(Color.mainPurple.opacity(0.8))
                        .padding()
                        .background(Color.lightShadow)
                        .cornerRadius(10)
                        .modifier(ShadowViewModifier())
                        
                        NavigationLink( destination: HomePageView(), isActive: $showViewHome){
                            EmptyView()
                        }
                    }
                    
                        
                    Button(action: {self.showViewSignUp = true}, label: {
                        Text("Already haven't an account? Sign up")
                            .bold()
                            .foregroundColor(.mainPurple)
                    }).foregroundColor(.blue)
                        .padding(.top,20)
                
                    Spacer()
                    
                    NavigationLink( destination: SignUpView(), isActive: $showViewSignUp){
                        EmptyView()
                    }
                    
                }.padding(30)
                .onAppear{
                   // self.showViewHome = signUpController.login(email: self.email, password: self.password)
                }
           
            
     }
        .navigationBarBackButtonHidden(true)

    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
            
        }
    }
}

extension Color{
    static let mainPurple = Color("mainPurple")
}

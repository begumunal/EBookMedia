//
//  SignUpView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 22.09.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct SignUpView: View {
    
    @State var buttonIsActive : Bool = false
    
    @State var name : String = ""
    @State var surename : String = ""
    @State var email : String = ""
    @State var password : String = ""
    @State var passwordAgain : String = ""
    @State var showWelcome : Bool = false
    @State var signUpController = SignUpController()
    
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    Rectangle().fill(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Spacer()
                        Text("REGISTER")
                            .fontWeight(.semibold)
                            .foregroundColor(.mainPurple)
                        
                        Text("create your new account")
                            .foregroundColor(.gray)
                        
                        TextField("name", text: $name)
                            .padding()
                            .cornerRadius(5)
                            .modifier(InnerShadowViewModifier())
                            .disableAutocorrection(true)
                            .padding(.bottom, 20)
                        
                        TextField("username", text: $surename)
                            .padding()
                            .cornerRadius(5)
                            .modifier(InnerShadowViewModifier())
                            .disableAutocorrection(true)
                            .padding(.bottom, 20)
                        
                        TextField("email", text: $email)
                            .padding()
                            .cornerRadius(5)
                            .modifier(InnerShadowViewModifier())
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(.bottom, 20)
                        
                        TextField("password", text: $password)
                            .padding()
                            .cornerRadius(5)
                            .modifier(InnerShadowViewModifier())
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(.bottom, 20)
                            
                        
                        TextField("password again", text: $passwordAgain)
                            .padding()
                            .cornerRadius(5)
                            .modifier(InnerShadowViewModifier())
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(.bottom, 20)
                        
                        HStack{
                            
                           Button(action: {
                               //REGISTER
                              // self.showWelcome = signUpController.register1(name: self.name, surename: self.surename, email: self.email, password: self.password)
                               if name != "" && surename != ""{
                                   Auth.auth().createUser(withEmail: email, password: password){result,error in
                                       if error != nil{
                                           print(error!.localizedDescription)
                                           //return showWelcome
                                       }else{
                                          
                                           showWelcome = true
                                           let user = User(name: name, surename: surename)
                                           
                                           var ref : DatabaseReference!
                                           ref = Database.database().reference()
                                           let userId = Auth.auth().currentUser?.uid
                                           //burada realtime a kaydederkenki id yi authentication a kaydederken aldığı id yi verdim bunun sebebi kullanıcıya ait realtime dan bir veri çekerken hangi id den çektiğim önemli.
                                           ref.child("users").child(userId!).setValue(["name" : user.name, "surename" : user.surename])
                                           //return true
                                       }
                                       
                                   }
                               }
                               
                            }, label: {
                                Spacer()
                                Text("sign up")
                                    .fontWeight(.bold)
                                Spacer()
                            })
                            .foregroundColor(Color.mainPurple.opacity(0.8))
                            .padding()
                            .background(Color.lightShadow)
                            .cornerRadius(10)
                            .modifier(ShadowViewModifier())
                            
                            NavigationLink( destination: WelcomeView(), isActive: $showWelcome){
                                EmptyView()
                            }
                        }      
                    }.padding(30)
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
struct ShadowViewModifier : ViewModifier{
    func body(content : Content) -> some View{
        content
            .shadow(color: Color("lightShadow"), radius: 8, x:-8, y: -8)
            .shadow(color: Color("darkShadow"), radius: 8, x:8, y: 8)
    }
}
struct InnerShadowViewModifier : ViewModifier{
    @State var radius: CGFloat = 10
    
    func body(content : Content) -> some View{
        content
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(Color.lightShadow, lineWidth: 4)
                    .shadow(color: Color.darkShadow, radius: 8, x:8, y: 8)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                    .shadow(color: Color.lightShadow, radius: 4, x:-5, y: -5)
            )
            
            
    }
}
extension Color{
    static let secondMainColor = Color("secondMainColor")
    static let darkShadow = Color("darkShadow")
    static let lightShadow = Color("lightShadow")
}

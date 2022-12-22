//
//  AddItemView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 25.09.2022.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var addItemController = AddItemController()
    @State var name : String = ""
    @State var description : String = ""

    @State var clickedSave = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 20){
                    
                    
                    TextField("book name", text: $name).padding().frame(width: 250, height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 4))
                    TextField("description", text: $description).padding().frame(width: 250, height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 4))
                    
                    HStack{
                        Spacer()
                        Button(action: {clickedSave.toggle()
                            if clickedSave{
                                if self.name != "" {
                                    self.addItemController.addItemDatabese(name: self.name, description: self.description)
                                    
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }, label: {Text("save").bold().foregroundColor(.mainPurple)}).foregroundColor(.mainPurple).buttonStyle(.bordered).frame(width: 200, height: 40, alignment: .leading).padding(.top,50)
                        
                        
                        Spacer()
                    }
                   
                }
            }
            
        }
        
    }
}

struct AddItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddItemView()
    }
}



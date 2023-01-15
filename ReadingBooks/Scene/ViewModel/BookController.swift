//
//  BookController.swift
//  ReadingBooks
//
//  Created by Begum Unal on 26.09.2022.
//

import Foundation

class BookController:ObservableObject{
    
    @Published var items = [Book]()
    
    func removeItem(item : Book){
        if let index = items.firstIndex(of: item){
            items.remove(at: index)
        }else{return}
    }
    
    /*func likeItem(){
        if let index = items.firstIndex(of: item){
            items[index].likeItem.toggle()
        }else{return}
    }*/
}


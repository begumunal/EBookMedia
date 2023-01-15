//
//  GetData.swift
//  ReadingBooks
//
//  Created by Begum Unal on 29.09.2022.
//

import Foundation
import SwiftyJSON
import SwiftUI
class GetData : ObservableObject{
    @Published var data = [Book]()
    
    init(){
        

        let url = "https://www.googleapis.com/books/v1/volumes?q=java"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data,_,err) in
            if err != nil {
                print(err?.localizedDescription)
                return
            }
            let json = try! JSON(data: data!)
            let items  = json["items"].array!
            for i in items{
                //buradaki anahtar kelimeler ggogle book api sini kullandığım için oradaki json verisilerinin anahtar kelimeleriyle aynı.
                let id = i["id"].stringValue
                let title = i["volumeInfo"]["title"].stringValue
               /* let authors = i["volumeInfo"]["authors"].array!
                
                var author = ""
                for j in authors{
                    author += "\(j.stringValue)"
                }*/
                var isLike = false 
                let description = i["volumeInfo"]["description"].stringValue
                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                let url = i["volumeInfo"]["previewLink"].stringValue
                var isFavorite = false
                DispatchQueue.main.async {
                    self.data.append(Book(id: id, title: title, /*author: author ,*/ desc: description, imurl: imurl, url: url,isLike: isLike, favoriteClicked: isFavorite))
                }
            }
        }.resume()
    }
}

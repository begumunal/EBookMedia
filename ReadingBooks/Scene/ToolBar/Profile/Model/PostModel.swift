//
//  PostModel.swift
//  ReadingBooks
//
//  Created by Begum Unal on 8.11.2022.
//

import Foundation
import UIKit

struct PostModel {
    var postId : String = ""
    var image : UIImage = UIImage()
    var imageUrl : String = ""
    var postDescription : String = ""
    var postIsLike : [String : Bool] = ["" : false]
    var byId : String = ""
    var date : Date = Date()
    var likeCount : Int = 0
    
}

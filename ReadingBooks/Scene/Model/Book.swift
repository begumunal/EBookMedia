//
//  BookData.swift
//  ReadingBooks
//
//  Created by Begum Unal on 25.09.2022.
//

import Foundation
import SwiftUI

public struct Book : Hashable, Codable, Identifiable{
    public var id : String
    public var title : String
    //public var author : String
    public var desc : String
    public var imurl : String
    public var url : String
    public var isLike : Bool
    public var favoriteClicked : Bool
}

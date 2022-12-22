//
//  User.swift
//  ReadingBooks
//
//  Created by Begum Unal on 22.09.2022.
//

import Foundation

public struct User : Identifiable{
    public var id = UUID().uuidString
    public var name : String
    public var surename : String
    //public var email : String
    //public var password : String
}

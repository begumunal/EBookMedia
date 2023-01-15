//
//  SearchUser.swift
//  ReadingBooks
//
//  Created by Begum Unal on 11.01.2023.
//

import Foundation

struct SearchUser : Encodable, Decodable{
    var uid : String
    var email : String
    var profileImageURL : String
    var name : String
    var surename : String
    var searchName : [String]
}

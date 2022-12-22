//
//  TableRow.swift
//  ReadingBooks
//
//  Created by Begum Unal on 25.09.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct TableRow: View {
    
    @ObservedObject var books = GetData()
    var body: some View {
        HStack {
            WebImage(url: <#T##URL?#>)
            
        }
    }
}

struct TableRow_Previews: PreviewProvider {
    static var previews: some View {
        TableRow()
    }
}



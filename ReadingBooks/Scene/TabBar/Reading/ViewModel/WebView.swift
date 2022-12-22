//
//  WebView.swift
//  ReadingBooks
//
//  Created by Begum Unal on 7.11.2022.
//

import Foundation
import UIKit
import SwiftUI

struct WebView : UIViewRepresentable{
    
    var url : String = ""
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let view = WKWebView()
        //view.load(URLRequest(url: URL(string: url)!))
        return view
    }
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
    
    
}

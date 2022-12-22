//
//  PostCell.swift
//  ReadingBooks
//
//  Created by Begum Unal on 10.11.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct PostCell: View {
    var post = PostModel()
    
    @State var liked = false
    @State var likecount = 0
    var header: some View {
        HStack {

            Image(uiImage: post.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(Auth.auth().currentUser!.email!).font(.system(size: 14)).bold()
            }
            
            Spacer()
            
            Image(systemName: "ellipsis").padding()
        }
    }
    
    var actionButtons: some View {
        HStack {
            Image(systemName: self.liked ? "heart.fill" : "heart")
                .renderingMode(.template)
                .foregroundColor(self.liked ? .red : Color(.label))
                .onTapGesture {
                    self.liked.toggle()
                    self.likecount = post.likeCount + 1
            }
            .padding(.init(top: 0, leading: 12, bottom: 0, trailing: 8))
            
            Text("\(self.likecount)")
            
            Spacer()
        }
        .font(.system(size: 21, weight: .light))
        .padding([.top, .bottom])
        .fixedSize(horizontal: false, vertical: true)
    }
    
    var textContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Group {
              //  Text("\(post.username) ").font(.system(size: 14)).bold() +
                Text(post.postDescription).font(.system(size: 14))
            }
            .padding([.leading, .trailing])
            
            Text("41 minutes ago")
                .foregroundColor(Color(.systemGray2))
                .font(.system(size: 14))
                .padding([.leading, .trailing])
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var body: some View {
        VStack {
            header
            
            Image(uiImage: post.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            
            actionButtons
            
            textContent
            
            Spacer()
        }
    }
}

struct Previews_PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell()
    }
}

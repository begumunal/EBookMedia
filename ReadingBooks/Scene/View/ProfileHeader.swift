//
//  ProfileHeader.swift
//  ReadingBooks
//
//  Created by Begum Unal on 15.12.2022.
//

import SwiftUI

struct ProfileHeader: View {
    var body: some View {
        VStack{
            HStack(spacing: 32){
                VStack(spacing: 2){
                    
                    Text("30")//bu kısım veritabanından çekilecek
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("books")
                        .font(.caption)
                }
               /* VStack(spacing: 2){
                    
                    Text("30")//bu kısım veritabanından çekilecek
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("posts")
                        .font(.caption)
                }*/
                VStack(spacing: 2){
                    Text("30")//bu kısım veritabanından çekilecek
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("followers")
                        .font(.caption)
                }
                VStack(spacing: 2){
                    Text("30")//bu kısım veritabanından çekilecek
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("following")
                        .font(.caption)
                }
            }
        }
        
       /* HStack{
            
            Text("\(userinfo.name)" + " " + "\(userinfo.username)") //veritabanından isim ve soyisim bilgileri çekiliyor
            Spacer()
        }*/
        Button(action: {}, label: {
            //BURADA KULLANICI TAKİP EDİLİP EDİLMEMESİNE GÖRE BUTON DEĞİŞECEK.
            Text("follow")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
        }).overlay(RoundedRectangle(cornerRadius: 4)
            .stroke(Color(.black)))
        .buttonStyle(.borderedProminent)
        
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader()
    }
}

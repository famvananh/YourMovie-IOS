//
//  SwiftUIView.swift
//  YourMovie
//
//  Created by Fam Van Anh on 23.03.21.
//  Copyright © 2021 Fam Van Anh. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Binding var showsecondView: Bool
    var title :String
    var year:String
    var overview:String
    
    var imageUrl:URL
    
    
    
    var body: some View {
        
        let imageData = (try? Data(contentsOf: imageUrl))!
        let uiImage = UIImage(data: imageData)!
        return
            ScrollView {
                ZStack(alignment: .bottom){
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Rectangle()
                        .frame(height: 80)
                        .opacity(0.50)
                        .blur(radius: 10)
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(title)")
                                .foregroundColor(.white)
                                .bold()
                                .font(.largeTitle)
                        }
                        .padding(.leading)
                        .padding(.bottom)
                        Spacer()
                        
//                        Text("\(year)")
//                            .foregroundColor(.white)
//                            .bold()
                        
                        
                    }
                    
                    
                }
                VStack(alignment: .center,spacing: 15) {
                    Text("\(overview)")
                        //                                   .foregroundColor(.primary)
                        //                                        .font(.)
                        .lineSpacing(8)
                        .padding(.leading)
                        .padding(.bottom)
                    
                    
                    
                }
                
                
        }
    }
}


//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView(showsecondView: .constant(false), title: "Name", year: "Data", overview:"overview")
//    }
//}

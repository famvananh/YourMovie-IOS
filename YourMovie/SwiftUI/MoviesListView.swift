//
//  MoviesListView.swift
//  YourMovie
//
//  Created by Fam Van Anh on 18.03.21.
//  Copyright © 2021 Fam Van Anh. All rights reserved.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var popularState :MovieViewModel
    @State private var showSecondView = false
    var message = "hi!"
    
    
    var body: some View {
        
        NavigationView {
            TabView {
                
                //       POPULAR
                
                List{
                    ForEach(popularState.popularMovies, id:\.self) { result in
                        VStack(alignment: .center){
                            Image(systemName: "Image").data(url: URL(string:"https://image.tmdb.org/t/p/w300" + result.posterImage!)!)
                                .scaledToFit()
                                .overlay(
                                    VStack(){
                                        HStack{
                                            Text(String(result.rate))
                                                .font(.system(size: 25.0))
                                                .foregroundColor(.black)
                                            
                                            Button(action:
                                                {
                                                    print("Your choose detail!")
                                                    self.showSecondView.toggle()
                                                    
                                                    
                                            }) {
                                                Image(systemName: "star")
                                                    .renderingMode(.original)
                                                    .frame(width: 25, height: 25)
                                                    .foregroundColor(.black)
                                                //
                                            }.sheet(isPresented: self.$showSecondView){
                                                MovieDetailView(showsecondView: self.$showSecondView, title:result.title, year: result.year, overview: result.overview, imageUrl: URL(string:"https://image.tmdb.org/t/p/w300" + result.posterImage!)!)
                                            }
                                        }
                                    }
                                        
                                    .background(Color.white)
                                    .opacity(1)
                                    .cornerRadius(5)
                                    .padding(6),alignment: .topLeading)
                            .cornerRadius(6)
                            Text(result.title).foregroundColor(.black).font(.headline).bold()
                        }
                    }
                }.tabItem{Image(systemName: "star.circle").font(.system(size:30.0))}
                
                //       SEARCH
                
                Text("SEARCH").tabItem{
                    Image(systemName: "magnifyingglass")
                }
                
            }
        }.navigationBarTitle(Text("POPULAR"))
            
            .onAppear(){
                self.popularState.fetchPopularMoviesData { (Movie) in
                    self.popularState.popularMovies = Movie
                }
                UITableView.appearance().separatorStyle = .none
        }
    }
}






struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(popularState: MovieViewModel())
    }
}
extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
        
    }
    
}

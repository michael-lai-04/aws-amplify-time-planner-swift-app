//
//  MovieDetailView.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 17/1/2023.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @State private var movieName: String = ""
    let coreDM: CoreDataManager
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack{
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update"){
                if !movieName.isEmpty{
                    movie.title = movieName
                    coreDM.updateMovie()
                    needsRefresh.toggle()
                }
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie()
        let coreDM = CoreDataManager()
        MovieDetailView(movie: movie, coreDM: coreDM, needsRefresh:.constant(false))
    }
}

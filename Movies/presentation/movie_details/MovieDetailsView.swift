//
//  MovieDetailsView.swift
//  ios_films
//
//  Created by Mateusz Filipek on 15/04/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    init(movie: DashboardElement) {
        self.movie = movie
        self._viewModel = StateObject(wrappedValue: MovieDetailsViewModel(movieId: movie.id))
    }
    
    let movie: DashboardElement

    @StateObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    // backdrop image
                    if let backdropUrl = movie.backdropUrl {
                        AsyncImage(url: URL(string: backdropUrl)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(16)
                        } placeholder: {
                            ProgressView()
                        }
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .bottom, endPoint: UnitPoint(x: 0.5, y: 0.8))
                        )
                    }
                }
                else {
                    if let posterUrl = movie.posterUrl {
                        AsyncImage(url: URL(string: posterUrl)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(16)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 450, alignment: .top)
                        .clipped()
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .bottom, endPoint: UnitPoint(x: 0.5, y: 0.85))
                        )
                    }
                }
                // if viewModel.movie is loading then show progress view
                // and viewModel.movie is nil
                if viewModel.movie == nil {
                    ProgressView()
                }
                else {

                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                    
                    if viewModel.movie!.releaseDate != nil {
                        HStack {
                            Text(viewModel.movie!.releaseDate!)
                                .font(.caption)
                                .fontWeight(.regular)
                                .padding(.horizontal, 10)
                            Divider()
                            Text(viewModel.movie!.genres.joined(separator: ", "))
                                .font(.caption)
                                .fontWeight(.regular)
                                .padding(.horizontal, 10)
                        }
                        
                    }
                    
                    Text(viewModel.movie!.overview)
                        .font(.title2)
                        .fontWeight(.regular)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)

                    VStack(alignment: .leading) {
                        Text("Director")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                        Text(viewModel.movie!.director.joined(separator: ", "))
                            .font(.title3)
                            .fontWeight(.regular)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                    }
                    VStack(alignment: .leading) {
                        Text("Writers")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                        Text(viewModel.movie!.writers.joined(separator: ", "))
                            .font(.title3)
                            .fontWeight(.regular)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                    }
                    VStack(alignment: .leading) {
                        Text("Cast")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.movie!.cast, id: \.self) { cast in
                                    posterView(poster: cast)
                                }
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Similar Movies")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.movie!.similar, id: \.self) { movie in
                                    posterView(poster: movie)
                                }
                            }
                        }
                    }
                }
                .offset(y: -60)
            }
            }
        }
        
    }
    
    func posterView(poster: ImageListModel) -> some View {
        VStack {
            if poster.posterUrl != nil {
            AsyncImage(url: URL(string: poster.posterUrl!)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .cornerRadius(16)
            } placeholder: {
                ProgressView()
            }
            } 
            else {
                Rectangle()
                    .frame(width: 100, height: 150)
                    .foregroundColor(.gray)
                    .cornerRadius(16)
            }
            Text(poster.title)
                .font(.title3)
                .fontWeight(.regular)
                .multilineTextAlignment(.leading)
                .lineLimit(1)

            Text(poster.subtitle)
                .font(.subheadline)
                .fontWeight(.regular)
                // make grey
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .lineLimit(1)

        }
        .frame(width: 100)
    
    }
}

let dummyMovie = DashboardElement(
    id: 1,
    title: "Title 1",
    subtitle: "Subtitle 1",
    posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
    backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
    profileUrl: nil,
    rating: "5.0",
    voteCount: 100,
    mediaType: .movie
)

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: dummyMovie)
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
            .previewDisplayName("iPad Pro (12.9-inch) (6th generation)")
            .padding()
        
        MovieDetailsView(movie: dummyMovie)
            .previewDevice("iPhone 14 Pro Max")
            .previewDisplayName("iPhone 14 Pro Max")
            .padding()
    }
}

// struct DetailedMovieModel: Identifiable, Hashable {
//     let id: Int
//     let title: String
//     let budget: String
//     let popularity: String
//     let runtime: Int?
//     let posterPath: String?
//     let releaseDate: String?
//     let originalLanguage: String
//     let distributor: [String]
//     let production: [String]
//     let genres: [String]
//     let voteCount: Int?
//     let rating: String
//     let overview: String
//     let director: [String]
//     let writers: [String]
//     let similar: [ImageListModel]
//     let cast: [ImageListModel]
// }

// struct ImageListModel: Identifiable, Hashable {
//     let id: Int
//     let title: String
//     let subtitle: String
//     let posterUrl: String?
//     let backdropUrl: String?
//     let profileUrl: String?
//     let rating: String
//     let isFavourite: Bool?
//     let mediaType: MediaType
//     let voteCount: Int?
// }

//let viewModel.movie = DetailedMovieModel(
//    id: 1,
//    title: "Title 1",
//    budget: "Budget 1",
//    popularity: "Popularity 1",
//    runtime: 100,
//    posterPath: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
//    releaseDate: "2021-01-01",
//    originalLanguage: "en",
//    distributor: ["Distributor 1"],
//    production: ["Production 1"],
//    genres: ["Genre 1"],
//    voteCount: 100,
//    rating: "5.0",
//    overview: "Overview 1",
//    director: ["Director 1"],
//    writers: ["Writer 1"],
//    similar: [ImageListModel(
//        id: 1,
//        title: "Title 1",
//        subtitle: "Subtitle 1",
//        posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
//        backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
//        profileUrl: nil,
//        rating: "5.0",
//        isFavourite: true,
//        mediaType: .movie,
//        voteCount: 100
//    )],
//    cast: [ImageListModel(
//        id: 1,
//        title: "Title 112312312312312312312312",
//        subtitle: "Subtitle 1123123123123123123123",
//        posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
//        backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
//        profileUrl: nil,
//        rating: "5.0",
//        isFavourite: true,
//        mediaType: .movie,
//        voteCount: 100
//    )]
//)

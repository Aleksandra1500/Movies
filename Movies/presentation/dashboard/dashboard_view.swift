//
//  dashboard_view.swift
//  ios_films
//
//  Created by Mateusz Filipek on 15/04/2023.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel = DashboardViewModel()

    var body: some View {
        // if loading show loading indicator
        if viewModel.isLoading {
            ProgressView()
        } else {
            TabView {
            ScrollView {
                VStack {
                    backdropList(
                        title: "Top Rated Movies",
                        items: viewModel.topRatedMovies
                    )
                    posterList(
                        title: "Popular Movies",
                        items: viewModel.popularMovies
                    )
                    posterList(
                        title: "Now Playing Movies",
                        items: viewModel.nowPlayingMovies
                    )
                    posterList(
                        title: "Upcoming Movies",
                        items: viewModel.upcomingMovies
                    )
                }
            }
            .tabItem {
                Image(systemName: "film")
                Text("Movies")
            }
            ScrollView {
                Text("Search")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
        }
           
    }

    func backdropList(title: String, items: [DashboardElement]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 10)
                .padding(.top, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Rectangle()
                        .frame(width: 10, height: 1)
                        .opacity(0)
                    ForEach(items) { item in
                        // backdropElement(item: item)
                        // backdrop element with navigation to MovieDetailsView
                        NavigationLink(destination: MovieDetailsView(movie: item)) {
                            backdropElement(item: item)
                        }
                    }
                    Rectangle()
                        .frame(width: 10, height: 1)
                        .opacity(0)
                }
            }
        }
    }

    func posterList(title: String, items: [DashboardElement]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 10)
                .padding(.top, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Rectangle()
                        .frame(width: 10, height: 1)
                        .opacity(0)
                    ForEach(items) { item in
                        NavigationLink(destination: MovieDetailsView(movie: item)) {
                            posterElement(item: item)
                        }
                    }
                    Rectangle()
                        .frame(width: 10, height: 1)
                        .opacity(0)
                }
            }
        }
    }

    func backdropElement(item: DashboardElement) -> some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                if let backdropUrl = item.backdropUrl {
                    AsyncImage(url: URL(string: backdropUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(16)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 320, height: 180)
                }
                if let rating = item.rating {
                    Text(rating)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding(.leading, 16)
                        .padding(.bottom, 12)
                }
            }
        }
    }

    func posterElement(item: DashboardElement) -> some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                if let posterUrl = item.posterUrl {
                    AsyncImage(url: URL(string: posterUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(16)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 180)
                }
                if let rating = item.rating {
                    Text(rating)
                        // .font(.title3)
                        // small font size
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding(.leading, 16)
                        .padding(.bottom, 12)
                }
            }
        }
    }
}

let dashboardElements = [
    DashboardElement(
        id: 1,
        title: "Title 1",
        subtitle: "Subtitle 1",
        posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
        backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
        profileUrl: nil,
        rating: "5.0",
        voteCount: 100,
        mediaType: .movie
    ),
    DashboardElement(
        id: 2,
        title: "Title 2",
        subtitle: "Subtitle 2",
        posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
        backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
        profileUrl: nil,
        rating: "5.0",
        voteCount: 100,
        mediaType: .movie
    ),
    DashboardElement(
        id: 3,
        title: "Title 3",
        subtitle: "Subtitle 3",
        posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
        backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
        profileUrl: nil,
        rating: "5.0",
        voteCount: 100,
        mediaType: .movie
    ),
    DashboardElement(
        id: 4,
        title: "Title 4",
        subtitle: "Subtitle 4",
        posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
        backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
        profileUrl: nil,
        rating: "5.0",
        voteCount: 100,
        mediaType: .movie
    ),
    DashboardElement(
        id: 5,
        title: "Title 5",
        subtitle: "Subtitle 5",
        posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
        backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
        profileUrl: nil,
        rating: "5.0",
        voteCount: 100,
        mediaType: .movie
    ),
    DashboardElement(
        id: 6,
        title: "Title 6",
        subtitle: "Subtitle 6",
        posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
        backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
        profileUrl: nil,
        rating: "5.0",
        voteCount: 100,
        mediaType: .movie
    ),
    DashboardElement(
        id: 7,
        title: "Title 7",
        subtitle: "Subtitle 7",
        posterUrl: "https://image.tmdb.org/t/p/w500/6vcDalR50RWa309vBH1NLmG2rjQ.jpg",
        backdropUrl: "https://image.tmdb.org/t/p/w500/qElNES0sHVQcbzvGrTx7ccpGzij.jpg",
        profileUrl: nil,
        rating: "5.0",
        voteCount: 100,
        mediaType: .movie
    ),
]

struct DashboardViewPreviews: PreviewProvider {
    static var previews: some View {
        // preview on Ipad Pro 12.9" 6th gen
        // and Iphone 14 Pro Max
        DashboardView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
            .previewDisplayName("iPad Pro (12.9-inch) (6th generation)")
            .padding()
        
        DashboardView()
            .previewDevice("iPhone 14 Pro Max")
            .previewDisplayName("iPhone 14 Pro Max")
            .padding()
        
    }
}

//
//  MovieDetailsRepositoryImpl.swift
//  ios_films
//
//  Created by Mateusz Filipek on 15/04/2023.
//

import Foundation


class MovieDetailsRepositoryImpl {
    private let movieDetailsDataSource: MovieDetailsDataSource

    init(movieDetailsDataSource: MovieDetailsDataSource) {
        self.movieDetailsDataSource = movieDetailsDataSource
    }

    func getMovieDetails(movieId: Int, completion: @escaping (Result<DetailedMovieModel, Error>) -> Void) {
        movieDetailsDataSource.getMovieDetails(movieId: movieId) { result in
            switch result {
            case .success(let movieDetailsDto):
                let movie = DetailedMovieModel(
                    id: movieDetailsDto.id,
                    title: movieDetailsDto.title,
                    budget: "\(movieDetailsDto.budget)",
                    popularity: "\(movieDetailsDto.popularity)",
                    runtime: movieDetailsDto.runtime,
                    posterPath: movieDetailsDto.posterPath,
                    releaseDate: movieDetailsDto.releaseDate,
                    originalLanguage: movieDetailsDto.originalLanguage,
                    genres: movieDetailsDto.genres.map { $0.name },
                    voteCount: movieDetailsDto.voteCount,
                    rating: "\(movieDetailsDto.voteAverage)",
                    overview: movieDetailsDto.overview,
                    // map crew to director and writers
                    director: movieDetailsDto.credits.crew.filter { $0.job == "Director" }.map { $0.name },
                    writers: movieDetailsDto.credits.crew.filter { $0.job == "Writer" }.map { $0.name },
                    // map cast to ImageListModel
                    similar: movieDetailsDto.similar.results.map { ImageListModel(
                        id: -1,
                        title: $0.title,
                        subtitle: "",
                        posterUrl: "https://image.tmdb.org/t/p/w500" + ($0.posterPath ?? ""),
                        backdropUrl: nil,
                        profileUrl: nil,
                        rating: "",
                        isFavourite: nil,
                        mediaType: .movie
                    ) },
                    cast: movieDetailsDto.credits.cast.map { ImageListModel(
                        id: -1,
                        title: $0.name,
                        subtitle: $0.character,
                        posterUrl: "https://image.tmdb.org/t/p/w500" + ($0.profilePath ?? ""),
                        backdropUrl: nil,
                        profileUrl: nil,
                        rating: "",
                        isFavourite: nil,
                        mediaType: .person
                    ) }
                )
                completion(.success(movie))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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

//
//  SearchRepositoryImpl.swift
//  Movies
//
//  Created by Mateusz Filipek on 21/04/2023.
//

import Foundation

class SearchRepositoryImpl: SearchRepository {
    private let searchDataSource: SearchDataSource

    init(searchDataSource: SearchDataSource) {
        self.searchDataSource = searchDataSource
    }

    func searchMovies(query: String, page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void) {
        searchDataSource.searchForMovies(query: query, page: page) { result in
            switch result {
            case .success(let basicMovieDtos):
                let dashboardElements = basicMovieDtos.map { basicMovieDto in
                    DashboardElement(
                        id: basicMovieDto.id,
                        title: basicMovieDto.title,
                        subtitle: basicMovieDto.releaseDate,
                        posterUrl: "https://image.tmdb.org/t/p/w500" + (basicMovieDto.posterPath ?? ""),
                        backdropUrl: "https://image.tmdb.org/t/p/w500" + (basicMovieDto.backdropPath ?? ""),
                        profileUrl: nil,
                        rating: String(basicMovieDto.voteAverage),
                        voteCount: basicMovieDto.voteCount,
                        mediaType: .movie
                    )
                }
                completion(.success(dashboardElements))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

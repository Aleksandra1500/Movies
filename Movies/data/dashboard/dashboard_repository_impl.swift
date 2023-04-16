//
//  dashboard_repository_impl.swift
//  ios_films
//
//  Created by Mateusz Filipek on 14/04/2023.
//

import Foundation

// implement DashboardRepository protocol
class DashboardRepositoryImpl: DashboardRepository {
    private let dashboardDataSource: DashboardDataSource

    // dashboard data source returns lists of BasicMovieDto, convert them to DashboardElement
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void) {
        dashboardDataSource.getTopRatedMovies(page: page) { result in
            switch result {
            case .success(let basicMovieDtos):
                let dashboardElements = basicMovieDtos.map { basicMovieDto in
                    DashboardElement(
                        id: basicMovieDto.id,
                        title: basicMovieDto.title,
                        subtitle: basicMovieDto.releaseDate,
                        posterUrl: "https://image.tmdb.org/t/p/w780" + (basicMovieDto.posterPath ?? ""),
                        backdropUrl: "https://image.tmdb.org/t/p/w780" + (basicMovieDto.backdropPath ?? ""),
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

    func getPopularMovies(page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void) {
        dashboardDataSource.getPopularMovies(page: page) { result in
            switch result {
            case .success(let basicMovieDtos):
                let dashboardElements = basicMovieDtos.map { basicMovieDto in
                    DashboardElement(
                        id: basicMovieDto.id,
                        title: basicMovieDto.title,
                        subtitle: basicMovieDto.releaseDate,
                        posterUrl: "https://image.tmdb.org/t/p/w780" + (basicMovieDto.posterPath ?? ""),
                        backdropUrl: "https://image.tmdb.org/t/p/w780" + (basicMovieDto.backdropPath ?? ""),
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

    func getNowPlayingMovies(page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void) {
        dashboardDataSource.getNowPlayingMovies(page: page) { result in
            switch result {
            case .success(let basicMovieDtos):
                let dashboardElements = basicMovieDtos.map { basicMovieDto in
                    DashboardElement(
                        id: basicMovieDto.id,
                        title: basicMovieDto.title,
                        subtitle: basicMovieDto.releaseDate,
                        posterUrl: "https://image.tmdb.org/t/p/w780" + (basicMovieDto.posterPath ?? ""),
                        backdropUrl: "https://image.tmdb.org/t/p/w780" + (basicMovieDto.backdropPath ?? ""),
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

    func getUpcomingMovies(page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void) {
        dashboardDataSource.getUpcomingMovies(page: page) { result in
            switch result {
            case .success(let basicMovieDtos):
                let dashboardElements = basicMovieDtos.map { basicMovieDto in
                    DashboardElement(
                        id: basicMovieDto.id,
                        title: basicMovieDto.title,
                        subtitle: basicMovieDto.releaseDate,
                        posterUrl: "https://image.tmdb.org/t/p/w780" + (basicMovieDto.posterPath ?? ""),
                        backdropUrl: "https://image.tmdb.org/t/p/w780" + (basicMovieDto.backdropPath ?? ""),
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

    init(dashboardDataSource: DashboardDataSource) {
        self.dashboardDataSource = dashboardDataSource
    }
}

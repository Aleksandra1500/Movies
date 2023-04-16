//
//  MovieDetailsViewModel.swift
//  ios_films
//
//  Created by Mateusz Filipek on 16/04/2023.
//

import Foundation

final class MovieDetailsViewModel: ObservableObject {
    @Published var movie: DetailedMovieModel?
    @Published var isLoading: Bool = true

    private let movieDetailsRepository: MovieDetailsRepositoryImpl

    init(
        movieId: Int
    ) {
        self.movieDetailsRepository = MovieDetailsRepositoryImpl(movieDetailsDataSource: MovieDetailsDataSource(
            apiKey: "1f54bd990f1cdfb230adb312546d765d", baseUrl: "https://api.themoviedb.org/3"
        ))

        Task {
            await fetchData(movieId: movieId)
        }
    }

    func fetchData(movieId: Int) async {
        isLoading = true
        
        movieDetailsRepository.getMovieDetails(movieId: movieId) {
                [weak self] result in
                switch result {
                case .success(let movie):
                    self?.movie = movie
                case .failure(let error):
                    print(error)
                }
            }
        
        isLoading = false
    }
}

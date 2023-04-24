//
//  SearchViewModel.swift
//  Movies
//
//  Created by Mateusz Filipek on 21/04/2023.
//

import Foundation


final class SearchViewModel: ObservableObject {
    @Published var searchResults: [DashboardElement] = []
    @Published var isLoading: Bool = false

    private let searchRepository: SearchRepository

    init() {
        self.searchRepository = SearchRepositoryImpl(searchDataSource: SearchDataSource(
            apiKey: "1f54bd990f1cdfb230adb312546d765d", baseUrl: "https://api.themoviedb.org/3"
        ))

        // Task {
        //     await searchForMovies(query: "Harry Potter")
        // }
    }

    func searchForMovies(query: String) async {
        isLoading = true

        do {
            let _: () = try await searchRepository.searchMovies(query: query, page: 1) {
                [weak self] result in
                switch result {
                case .success(let movies):
                    self?.searchResults = movies
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            print(error)
        }

        isLoading = false
    }
}

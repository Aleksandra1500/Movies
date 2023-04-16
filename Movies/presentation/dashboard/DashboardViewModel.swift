//
//  DashboardViewModel.swift
//  ios_films
//
//  Created by Mateusz Filipek on 15/04/2023.
//

import Foundation

final class DashboardViewModel: ObservableObject {
    @Published var topRatedMovies: [DashboardElement] = []
    @Published var popularMovies: [DashboardElement] = []
    @Published var nowPlayingMovies: [DashboardElement] = []
    @Published var upcomingMovies: [DashboardElement] = []
    @Published var isLoading: Bool = false

    private let dashboardRepository: DashboardRepository

    init() {
        self.dashboardRepository = DashboardRepositoryImpl(dashboardDataSource: DashboardDataSource(
            apiKey: "1f54bd990f1cdfb230adb312546d765d", baseUrl: "https://api.themoviedb.org/3"
        ))
        
        Task {
            await fetchData()
        }
    }

    // async func to fetch data and set loading state
    func fetchData() async {
        isLoading = true
        do {
            await getTopRatedMovies()
            await getPopularMovies()
            await getNowPlayingMovies()
            await getUpcomingMovies()
        } catch {
            print(error)
        }
        isLoading = false
    }

    func getTopRatedMovies() {
        dashboardRepository.getTopRatedMovies(page: 1) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.topRatedMovies = movies
            case .failure(let error):
                print(error)
            }
        }
    }

    func getPopularMovies() {
        dashboardRepository.getPopularMovies(page: 1) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.popularMovies = movies
            case .failure(let error):
                print(error)
            }
        }
    }

    func getNowPlayingMovies() {
        dashboardRepository.getNowPlayingMovies(page: 1) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.nowPlayingMovies = movies
            case .failure(let error):
                print(error)
            }
        }
    }

    func getUpcomingMovies() {
        dashboardRepository.getUpcomingMovies(page: 1) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.upcomingMovies = movies
            case .failure(let error):
                print(error)
            }
        }
    }
}

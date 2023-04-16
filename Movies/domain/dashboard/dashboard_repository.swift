//
//  dashboard_repository.swift
//  ios_films
//
//  Created by Mateusz Filipek on 14/04/2023.
//

import Foundation

protocol DashboardRepository {
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void)
    func getPopularMovies(page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void)
    func getNowPlayingMovies(page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void)
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void)
}
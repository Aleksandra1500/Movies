//
//  SearchRepository.swift
//  Movies
//
//  Created by Mateusz Filipek on 21/04/2023.
//

import Foundation

protocol SearchRepository {
    func searchMovies(query: String, page: Int, completion: @escaping (Result<[DashboardElement], Error>) -> Void)
}
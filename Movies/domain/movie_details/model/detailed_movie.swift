//
//  detailed_movie.swift
//  ios_films
//
//  Created by Mateusz Filipek on 15/04/2023.
//

import Foundation

struct DetailedMovieModel: Identifiable, Hashable {
    let id: Int
    let title: String
    let budget: String
    let popularity: String
    let runtime: Int?
    let posterPath: String?
    let releaseDate: String?
    let originalLanguage: String
    let genres: [String]
    let voteCount: Int?
    let rating: String
    let overview: String
    let director: [String]
    let writers: [String]
    let similar: [ImageListModel]
    let cast: [ImageListModel]
}

struct ImageListModel: Identifiable, Hashable {
    let id: Int
    let title: String
    let subtitle: String
    let posterUrl: String?
    let backdropUrl: String?
    let profileUrl: String?
    let rating: String
    let isFavourite: Bool?
    let mediaType: MediaType
}

//
//  basic_movie_dto.swift
//  ios_films
//
//  Created by Mateusz Filipek on 14/04/2023.
//

import Foundation

struct BasicMovieDto: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int?
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }

    init(
        id: Int,
        title: String,
        posterPath: String?,
        backdropPath: String?,
        voteAverage: Double,
        voteCount: Int?,
        releaseDate: String
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.releaseDate = releaseDate
    } 
}


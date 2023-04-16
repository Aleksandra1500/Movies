//
//  MovieDetailsDto.swift
//  ios_films
//
//  Created by Mateusz Filipek on 15/04/2023.
//

import Foundation

struct MovieDetailsDto: Codable {
    let id: Int
    let budget: Int
    let runtime: Int?
    let popularity: Double
    let posterPath: String?
    let title: String
    let releaseDate: String
    let originalLanguage: String
    let genres: [GenreDto]
    let credits: CreditsDto
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let similar: PagedResultsDto<BasicMovieObjectDto>

    enum CodingKeys: String, CodingKey {
        case id
        case budget
        case runtime
        case popularity
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case genres
        case credits
        case overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case similar
    }
}    

// similar movie dto struct with poster_path and title
struct BasicMovieObjectDto: Codable {
    let posterPath: String?
    let title: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
    }
}

struct PagedResultsDto<T: Codable>: Codable {
    let page: Int
    let totalPages: Int
    let results: [T]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
}


struct GenreDto: Codable {
    let id: Int
    let name: String
}

struct CreditsDto: Codable {
    let cast: [CastPersonDto]
    let crew: [CrewPersonDto]
}

struct CastPersonDto: Codable {
    let name: String
    let profilePath: String?
    let character: String

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}

struct CrewPersonDto: Codable {
    let name: String
    let profilePath: String?
    let job: String

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case job
    }
}


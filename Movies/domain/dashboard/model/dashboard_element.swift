//
//  dashboard_element.swift
//  ios_films
//
//  Created by Mateusz Filipek on 14/04/2023.
//

import Foundation

struct DashboardElement: Identifiable, Hashable {
    let id: Int
    let title: String
    let subtitle: String
    let posterUrl: String?
    let backdropUrl: String?
    let profileUrl: String?
    let rating: String
    let voteCount: Int?
    let mediaType: MediaType
}
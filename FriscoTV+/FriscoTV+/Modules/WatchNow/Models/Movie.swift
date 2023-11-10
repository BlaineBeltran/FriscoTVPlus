//
//  Movie.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/11/23.
//

import Foundation

struct PaginatedResult<T: Codable>: Codable {
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int
}

struct Movie: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    var imageURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(String(describing: posterPath))")
    }
}

// Sample movie to use in previews
extension Movie {
    static let sample = Movie(adult: false, backdropPath: "/4fLZUr1e65hKPPVw0R3PmKFKxj1.jpg", genreIds: [16,35,10751,14,10749], id: 976573, originalLanguage: "en", originalTitle: "Elemental", overview: "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common.", popularity: 467.32, posterPath: "/4Y1WNkd88JXmGfhtWR7dmDAo1T2.jpg", releaseDate: "2023-06-14", title: "Elemental", video: false, voteAverage: 7.749, voteCount: 2753)
}

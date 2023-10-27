//
//  ComingSoonMovieService.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/26/23.
//

import Foundation

protocol ComingSoonMovieServicing {
    func fetchComingSoonMovies(page: Int) async throws -> PaginatedResult<Movie>
}

struct ComingSoonMovieEndpoint: Endpoint {
    let page: Int
    let token: String
    var path = "/3/movie/upcoming"
    var method: RequestMethod = .get
    var body: [String : String]?
    var headers: [String : String]? {
        ["Authorization": "Bearer \(token)"]
    }
    var parameters: [String : Int]? {
        ["with_genres": 10751,
         "page": page]
    }
    
    init(page: Int) {
        let env = ProcessInfo.processInfo.environment
        guard let apiToken = env["MOVIE_TOKEN"] else { preconditionFailure("Missing Environment Variables") }
        self.token = apiToken
        self.page = page
    }
}

struct ComingSoonMovieService {
    let client: HTTPClient
    
    init(client: HTTPClient = HTTPClient()) {
        self.client = client
    }
    
    func fetchComingSoonMovies(page: Int = 1) async throws -> PaginatedResult<Movie> {
        let comingSoonMovies = try await client.makeRequest(for: ComingSoonMovieEndpoint(page: page), objectType: PaginatedResult<Movie>.self)
        return comingSoonMovies
    }
}

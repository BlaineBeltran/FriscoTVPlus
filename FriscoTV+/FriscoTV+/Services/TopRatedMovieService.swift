//
//  TopRatedMovieService.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/25/23.
//

import Foundation

protocol TopRatedMovieServicing {
    func fetchTopRatedMovies(page: Int) async throws -> PaginatedResult<Movie>
}

struct TopRatedEndpoint: Endpoint {
    let token: String
    let page: Int
    var path = "/3/movie/popular"
    var method: RequestMethod = .get
    var headers: [String : String]? {
        ["Authorization": "Bearer \(token)"]
    }
    var body: [String : String]? = nil
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

struct TopRatedMovieService: TopRatedMovieServicing {
    let client: HTTPClient
    
    init(client: HTTPClient = HTTPClient()) {
        self.client = client
    }
    
    func fetchTopRatedMovies(page: Int = 1) async throws -> PaginatedResult<Movie> {
        let topRatedMovies = try await client.makeRequest(for: TopRatedEndpoint(page: page), objectType: PaginatedResult<Movie>.self)
        return topRatedMovies
    }
}

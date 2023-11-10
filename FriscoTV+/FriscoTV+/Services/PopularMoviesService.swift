//
//  PopularMoviesService.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/12/23.
//

import Foundation

protocol PopularMovieServicing {
    func fetchPopularMovies(page: Int) async throws -> PaginatedResult<Movie>
}

struct PopularMoviesEndpoint: Endpoint {
    let page: Int
    let token: String
    var path = "/3/discover/movie"
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

struct PopularMoviesService: PopularMovieServicing {
    let client: HTTPClientRequesting
    
    init(client: HTTPClientRequesting = HTTPClient()) {
        self.client = client
    }
    
    func fetchPopularMovies(page: Int = 1) async throws -> PaginatedResult<Movie> {
        let paginatedPopularMovies = try await client.makeRequest(for: PopularMoviesEndpoint(page: page), objectType: PaginatedResult<Movie>.self)
        return paginatedPopularMovies
    }
}

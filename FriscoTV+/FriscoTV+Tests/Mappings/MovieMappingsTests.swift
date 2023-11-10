//
//  MovieMappingsTests.swift
//  FriscoTV+Tests
//
//  Created by Blaine Beltran on 11/10/23.
//

@testable import FriscoTV_
import XCTest

final class MovieMappingsTests: XCTestCase, Mockable {

    func testMovieMappings() {
        verifyCorrectMovie()
    }
}

extension MovieMappingsTests {
    
    /// When  it's necessary to assert multiple things at once, put them into a verification method instead of in a test method
    func verifyCorrectMovie(file: StaticString = #file, line: UInt = #line) {
        let movie = loadJSON(filename: "MockMovie", type: Movie.self)
        
        XCTAssertNotNil(movie.adult)
        XCTAssertNotNil(movie.backdropPath)
        XCTAssertNotNil(movie.genreIds)
        XCTAssertNotNil(movie.id)
        XCTAssertNotNil(movie.originalLanguage)
        XCTAssertNotNil(movie.originalTitle)
        XCTAssertNotNil(movie.overview)
        XCTAssertNotNil(movie.popularity)
        XCTAssertNotNil(movie.posterPath)
        XCTAssertNotNil(movie.releaseDate)
        XCTAssertNotNil(movie.title)
        XCTAssertNotNil(movie.video)
        XCTAssertNotNil(movie.voteAverage)
        XCTAssertNotNil(movie.voteCount)
    }
}

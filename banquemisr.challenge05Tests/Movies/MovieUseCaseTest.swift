//
//  MovieUseCaseTest.swift
//  banquemisr.challenge05Tests
//
//  Created by mac on 19/07/2024.
//

import XCTest
import NetworkService
@testable import banquemisr_challenge05



final class MovieUseCaseTest: XCTestCase {
    
    var useCase: MovieUseCase!
    var movieRepoMock: MovieContract!
    var apiClient: HttpClientProtocol!
    
    
    override func setUp() {
        apiClient = MockApiClient()
        movieRepoMock = MovieRepositoryMock(apiClient: apiClient)
        useCase = MovieUseCase(movieRepo: movieRepoMock)
    }
    
    override func tearDown() {
        useCase = nil
        movieRepoMock = nil
        apiClient = nil
    }
    
    func testGetPopularMovies() async throws {
        // When
        let model = try await movieRepoMock.getPopularMovies()
        let count = model.results?.count
        // Then
        XCTAssertEqual(count , 3)
    }
    
    func testGetPlayingnowMovies() async throws {
        // When
        let model = try await movieRepoMock.getNowPlayingMovies()
        let count = model.results?.count
        // Then
        XCTAssertEqual(count , 2)
    }
    
    func testGetUpcomingMovies() async throws {
        // When
        let model = try await movieRepoMock.getUpcomingMovies()
        let count = model.results?.count
        // Then
        XCTAssertEqual(count , 4)
    }
    
    func testIsCurrentMovieDifferentFromCashing() async throws {
        let model = try await movieRepoMock.getPopularMovies()
        let isDifferent = useCase.isCurrentMovieDifferent(from: model, fileName: "popular-movies")
        XCTAssertEqual(isDifferent , true)
    }
}

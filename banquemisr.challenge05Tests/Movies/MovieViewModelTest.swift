//
//  MovieViewModelTest.swift
//  banquemisr.challenge05Tests
//
//  Created by mac on 19/07/2024.
//

import XCTest
import NetworkService
import Combine
@testable import banquemisr_challenge05


final class MovieViewModelTest: XCTestCase {
    
    var useCase: MovieUseCase!
    var movieRepoMock: MovieContract!
    var apiClient: HttpClientProtocol!
    var movieViewModel: MovieViewModel!
    private var cancellable = Set<AnyCancellable>()
    
    
    
    override func setUp() {
        apiClient = MockApiClient()
        movieRepoMock = MovieRepositoryMock(apiClient: apiClient)
        useCase = MovieUseCase(movieRepo: movieRepoMock)
        movieViewModel = MovieViewModel(usecase: useCase, coordinator: nil)
        
    }
    
    override func tearDown()  {
        apiClient = nil
        movieRepoMock = nil
        useCase = nil
        movieViewModel = nil
    }
    
    func testPopularMovies() {
        // Given
        movieViewModel.setupSelectedMovitype(.popular)
        
        let expectation = self.expectation(description: "Fetching movies")
        // When
        movieViewModel.getPopularMovies()
        // Then
        movieViewModel.popularMovieListPublisher
            .sink { movies in
                if movies.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        let listCount = movieViewModel.getMovieListCount()
        let movieDetails = movieViewModel.getMovieDetails(index:0)

        XCTAssertEqual(listCount, 3)
        XCTAssertEqual(movieDetails.id, 519182)

    }
    
    func testNowPlayingMovies() {
        // Given
        movieViewModel.setupSelectedMovitype(.playingNow)
        
        let expectation = self.expectation(description: "Fetching movies")
        // When
        movieViewModel.getNowPlayingMovies()
        // Then
        movieViewModel.playingNowMovieListPublisher
            .sink { movies in
                if movies.count == 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
                
        waitForExpectations(timeout: 5, handler: nil)
        
        let listCount = movieViewModel.getMovieListCount()
        let movieDetails = movieViewModel.getMovieDetails(index:0)

        XCTAssertEqual(listCount, 2)
        XCTAssertEqual(movieDetails.id, 748783)

    }
    
    
    func testUpcomingMovies() {
        // Given
        movieViewModel.setupSelectedMovitype(.upcoming)
        
        let expectation = self.expectation(description: "Fetching movies")
        // When
        movieViewModel.getUpcomingMovies()
        // Then
        movieViewModel.upcomingMovieListPublisher
            .sink { movies in
                if movies.count == 4 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        let listCount = movieViewModel.getMovieListCount()
        let movieDetails = movieViewModel.getMovieDetails(index:0)

        XCTAssertEqual(listCount, 4)
        XCTAssertEqual(movieDetails.id, 646683)

    }
    
}

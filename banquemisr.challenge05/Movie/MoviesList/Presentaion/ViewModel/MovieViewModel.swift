//
//  MovieViewModel.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation
import Combine
import NetworkService
import UIKit



class MovieViewModel {
    
    private var usecase: MovieUseCaseContract
    
    @Published private var popularMovieList = [MovieListEntity]()
    @Published private var playingNowMovieList = [MovieListEntity]()
    @Published private var upcomingMovieList = [MovieListEntity]()
    @Published private var movietype: MovieType = .popular
    @Published private var isLoading: Bool?
    @Published private var errorMessage: String?
    
    @Published var loadedImage: Data?
    
    var coordinator: MovieCoordinator!
    
    init(usecase: MovieUseCaseContract) {
        self.usecase = usecase
    }
    
    func navigateToMovieDetails(movieDetails: MovieListEntity) {
        coordinator.navigateToMovieDetails(with: movieDetails)
    }
    
}

extension MovieViewModel: MovieViewModelInputType {
    
}

extension MovieViewModel: MovieViewModelOutputType {
    
    var errorMessagePublisher: AnyPublisher<String?, Never> {
        $errorMessage
            .eraseToAnyPublisher()
    }
    
    var isLoadingPublisher: AnyPublisher<Bool?, Never> {
        $isLoading
            .eraseToAnyPublisher()
    }
    
    var movieTypePublisher: AnyPublisher<MovieType, Never> {
        $movietype
            .eraseToAnyPublisher()
    }
    
    var popularMovieListPublisher: AnyPublisher<[MovieListEntity], Never> {
        $popularMovieList
            .eraseToAnyPublisher()
    }
    
    var playingNowMovieListPublisher: AnyPublisher<[MovieListEntity], Never> {
        $playingNowMovieList
            .eraseToAnyPublisher()
    }
    
    var upcomingMovieListPublisher: AnyPublisher<[MovieListEntity], Never> {
        $upcomingMovieList
            .eraseToAnyPublisher()
    }
    
    var loadedImagePublisher: AnyPublisher<Data?, Never> {
        $loadedImage
            .eraseToAnyPublisher()
    }
    
    func featchMovieType() {
        isLoading = true
        switch movietype {
        case .popular: getPopularMovies()
        case .playingNow: getNowPlayingMovies()
        case .upcoming: getUpcomingMovies()
        }
    }
    
    // Generic method to fetch movies and update lists
    private func fetchMovies(
        fetch:  @escaping () async throws -> MovieEntity?,
        updateList: @escaping ([MovieListEntity]) -> Void
    ) {
        Task {
            isLoading = true
            do {
                let movieDTO = try await fetch()
                var movieResults = movieDTO?.results ?? []
                
                // Load images for each movie
                for index in 0..<movieResults.count {
                    if let posterPath = movieResults[index].posterPath, let url = URL(string: posterPath) {
                        do {
                            let imageData = try await usecase.loadImage(url: url)
                            movieResults[index].url = imageData
                        } catch {
                            print("Failed to load image for \(posterPath)")
                        }
                    }
                }
                
                // Update the list with the fetched and processed data
                updateList(movieResults)
                
                isLoading = false

            } catch let error as ApiErrorModel {
                isLoading = false
                errorMessage = error.statusMessage ?? "Something went wrong, try again."
            }
        }
    }

    func getPopularMovies() {
        fetchMovies(
            fetch: { try await self.usecase.getPopularMovies() },
            updateList: { [weak self] results in self?.popularMovieList = results }
        )
    }

    func getNowPlayingMovies() {
        fetchMovies(
            fetch: { try await self.usecase.getNowPlayingMovies() },
            updateList: { [weak self] results in self?.playingNowMovieList = results }
        )
    }

    func getUpcomingMovies() {
        fetchMovies(
            fetch: { try await self.usecase.getUpcomingMovies() },
            updateList: { [weak self] results in self?.upcomingMovieList = results }
        )
    }
        
    func getMovieListCount() -> Int {
        switch movietype {
        case .popular: return popularMovieList.count
        case .playingNow: return playingNowMovieList.count
        case .upcoming: return upcomingMovieList.count
        }
    }
    
    func getMovieDetails(index: Int)-> MovieListEntity {
        switch movietype {
        case .popular: return popularMovieList[index]
        case .playingNow: return playingNowMovieList[index]
        case .upcoming: return upcomingMovieList[index]
        }
    }
    
    func setupSelectedMovitype(_ type: MovieType) {
        movietype = type
    }
    
    
}


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
    
    @Published private var popularMovieList: [MovieListEntity] = []
    @Published private var playingNowMovieList: [MovieListEntity] = []
    @Published private var upcomingMovieList: [MovieListEntity] = []
    @Published private var movietype: MovieType = .popular
    @Published private var isLoading: Bool?
    @Published private var errorMessage: String?
    
        
    private let coordinator: MovieCoordinator
    
    init(usecase: MovieUseCaseContract, coordinator: MovieCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func navigateToMovieDetails(movieDetails: MovieListEntity) {
        coordinator.navigateToMovieDetails(with: movieDetails)
    }
    
    private func fetchMovies(
        fetch:  @escaping () async throws -> MovieEntity?,
        updateList: @escaping ([MovieListEntity]) -> Void
    ) {
        Task {
            isLoading = true
            do {
                let movieEntity = try await fetch()
                var movieResults = movieEntity?.results ?? []
                
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
                updateList(movieResults)
                isLoading = false

            } catch let error as ApiErrorModel {
                isLoading = false
                errorMessage = error.statusMessage ?? "Something went wrong, try again."
            }
        }
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
    
    func featchMovieType() {
        isLoading = true
        switch movietype {
        case .popular: getPopularMovies()
        case .playingNow: getNowPlayingMovies()
        case .upcoming: getUpcomingMovies()
        }
    }
     

    func getPopularMovies() {
        fetchMovies(
            fetch: { [weak self] in try await self?.usecase.getPopularMovies() },
            updateList: { results in self.popularMovieList = results
            }
        )
    }

    func getNowPlayingMovies() {
        fetchMovies(
            fetch: { [weak self] in try await self?.usecase.getNowPlayingMovies() },
            updateList: { results in self.playingNowMovieList = results
            }
        )
    }

    func getUpcomingMovies() {
        fetchMovies(
            fetch: { [weak self] in try await self?.usecase.getUpcomingMovies() },
            updateList: { results in self.upcomingMovieList = results
            }
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


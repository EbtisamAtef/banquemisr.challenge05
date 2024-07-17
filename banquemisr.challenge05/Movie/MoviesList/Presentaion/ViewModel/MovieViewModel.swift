//
//  MovieViewModel.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation
import Combine
import NetworkService

class MovieViewModel {
    
    private var usecase: MovieUseCaseContract
    
    @Published private var popularMovieList = [MovieListEntity]()
    @Published private var playingNowMovieList = [MovieListEntity]()
    @Published private var upcomingMovieList = [MovieListEntity]()
    

    init(usecase: MovieUseCaseContract) {
        self.usecase = usecase
        
    }
    
}

extension MovieViewModel: MovieViewModelInputType {
    
}

extension MovieViewModel: MovieViewModelOutputType {
    
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
    
    func getPopularMovies() {
        Task {
            do {
                let movie = try await usecase.getPopularMovies()
                popularMovieList = movie.results ?? []
            } catch let error as ApiErrorModel{
                print(error)

            }
        }
    }
    
    func getNowPlayingMovies() {
        Task {
            do {
                let movie = try await usecase.getNowPlayingMovies()
                playingNowMovieList = movie.results ?? []
            } catch let error as ApiErrorModel{
                print(error)
            }
        }
    }
    
    func getUpcomingMovies() {
        Task {
            do {
                let movie = try await usecase.getUpcomingMovies()
                upcomingMovieList = movie.results ?? []
             } catch let error as ApiErrorModel{
                 print(error)
            }
        }
    }
    
    
}


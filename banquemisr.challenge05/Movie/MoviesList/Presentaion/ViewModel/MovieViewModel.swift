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

enum MovieType: Int{
    case popular = 0
    case playingNow = 1
    case upcoming = 2
}

class MovieViewModel {
    
    private var usecase: MovieUseCaseContract
    
    @Published private var popularMovieList = [MovieListEntity]()
    @Published private var playingNowMovieList = [MovieListEntity]()
    @Published private var upcomingMovieList = [MovieListEntity]()
    @Published private var movietype: MovieType = .popular
    @Published var loadedImage: Data? = nil


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
    
    func loadImage(url: URL) {
        Task {
            do {
                let data = try await usecase.loadImage(url: url)
                //DispatchQueue.main.async {
                    loadedImage = data
                print("loaded Data", UIImage(data: loadedImage ?? Data()))
                //}
            } catch let error as ApiErrorModel{
                print(error)
            }
        }
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
    
    func setMovitype(_ type: MovieType) {
        movietype = type
    }
    

    
}


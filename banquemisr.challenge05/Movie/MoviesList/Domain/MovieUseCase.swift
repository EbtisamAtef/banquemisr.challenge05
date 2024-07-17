//
//  MovieUseCase.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation

struct MovieUseCase: MovieUseCaseContract {
    
    private let movieRepo: MovieContract
    
    init(movieRepo: MovieContract) {
        self.movieRepo = movieRepo
    }
    
    func getPopularMovies() async throws -> MovieEntity {
            let model = try await movieRepo.getPopularMovies()
            return Mapper.converMovieDTO(model)
    }
    
    func getNowPlayingMovies() async throws -> MovieEntity {
        let model = try await movieRepo.getNowPlayingMovies()
        return Mapper.converMovieDTO(model)    }
    
    func getUpcomingMovies() async throws -> MovieEntity {
//        if connectivityStatus.isConnected {
//            // from api
//        }else {
//            // from caching
//        }
        let model = try await movieRepo.getUpcomingMovies()
        return Mapper.converMovieDTO(model)
    }
    
}

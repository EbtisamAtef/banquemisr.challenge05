//
//  MovieUseCase.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation
import NetworkService

struct MovieUseCase: MovieUseCaseContract {
    
    private let movieRepo: MovieContract
    
    init(movieRepo: MovieContract) {
        self.movieRepo = movieRepo
    }
    
    func getPopularMovies() async throws -> MovieEntity? {
        let connectivityStatus = await Reachability.checkNetworkConnectivity()
        if connectivityStatus.isConnected {
            let model = try await movieRepo.getPopularMovies()
            CacheManager.shared.saveToFile(model, fileName: "popular-Movies.json")
            return Mapper.converMovieDTO(model)
        }else {
            guard let retrievedData: MovieDTO = CacheManager.shared.retrieveFromFile(fileName: "playing-now-Movies.json", as: MovieDTO.self) else {
                return nil
            }
            return Mapper.converMovieDTO(retrievedData)
        }
    }
    
    func getNowPlayingMovies() async throws -> MovieEntity? {
        let connectivityStatus = await Reachability.checkNetworkConnectivity()
        if connectivityStatus.isConnected {
            let model = try await movieRepo.getNowPlayingMovies()
            CacheManager.shared.saveToFile(model, fileName: "playing-now-Movies.json")
            return Mapper.converMovieDTO(model)
            
        }else {
            guard let retrievedData: MovieDTO = CacheManager.shared.retrieveFromFile(fileName: "playing-now-Movies.json", as: MovieDTO.self) else {
                return nil
            }
            return Mapper.converMovieDTO(retrievedData)
        }
        
    }
    
    func getUpcomingMovies() async throws -> MovieEntity? {
        let connectivityStatus = await Reachability.checkNetworkConnectivity()
        if connectivityStatus.isConnected {
            let model = try await movieRepo.getUpcomingMovies()
            CacheManager.shared.saveToFile(model, fileName: "upcoming-Movies.json")
            return Mapper.converMovieDTO(model)
            
        }else {
            guard let retrievedData: MovieDTO = CacheManager.shared.retrieveFromFile(fileName: "upcoming-Movies.json", as: MovieDTO.self) else {
                return nil
            }
            return Mapper.converMovieDTO(retrievedData)
            
        }
    }
    
    func loadImage(url: URL) async throws -> Data {
        return try await movieRepo.loadImage(url: url)
    }
    
}

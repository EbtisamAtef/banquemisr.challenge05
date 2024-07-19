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
            saveMovieData(from: model, fileName: "popular-Movies.json")
            return Mapper.converMovieDTO(model)
            
        }else {
            guard let retrievedData: MovieDTO = CacheManager.shared.retrieveFromFile(fileName: "popular-Movies.json", as: MovieDTO.self) else {
                return nil
            }
            return Mapper.converMovieDTO(retrievedData)
        }
    }
    
    func getNowPlayingMovies() async throws -> MovieEntity? {
        let connectivityStatus = await Reachability.checkNetworkConnectivity()
        if connectivityStatus.isConnected {
            let model = try await movieRepo.getNowPlayingMovies()
            saveMovieData(from: model, fileName: "playing-now-Movies.json")
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
            saveMovieData(from: model, fileName: "upcoming-Movies.json")
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
    
    private func saveMovieData(from model: MovieDTO, fileName: String) {
        if isCurrentMovieDifferent(from: model, fileName: fileName){
            CacheManager.shared.deleteFromFile(fileName: fileName)
            CacheManager.shared.saveToFile(model, fileName: fileName)
        }
    }
    
    private func isCurrentMovieDifferent(from currentMovie: MovieDTO, fileName: String) -> Bool {
        guard let savedMovies = CacheManager.shared.retrieveFromFile(fileName: fileName, as: MovieDTO.self) else {
            return true
        }
        let current = currentMovie.results ?? []
        let saved = savedMovies.results ?? []
        return !(saved.contains(current))
    }
    
    
    
}

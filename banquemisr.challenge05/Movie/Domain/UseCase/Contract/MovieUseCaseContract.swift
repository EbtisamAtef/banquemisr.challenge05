//
//  MovieUseCaseContract.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation

protocol MovieUseCaseContract {
    func getPopularMovies() async throws -> MovieEntity?
    func getNowPlayingMovies() async throws -> MovieEntity?
    func getUpcomingMovies() async throws -> MovieEntity?
    func loadImage(url: URL) async throws -> Data
    func saveMovieData(from model: MovieDTO, fileName: String)
    func isCurrentMovieDifferent(from currentMovie: MovieDTO, fileName: String) -> Bool
}

extension MovieUseCaseContract {
    
    func saveMovieData(from model: MovieDTO, fileName: String) {
        if isCurrentMovieDifferent(from: model, fileName: fileName){
            CacheManager.shared.deleteFromFile(fileName: fileName)
            CacheManager.shared.saveToFile(model, fileName: fileName)
        }
    }
    
    func isCurrentMovieDifferent(from currentMovie: MovieDTO, fileName: String) -> Bool {
        guard let savedMovies = CacheManager.shared.retrieveFromFile(fileName: fileName, as: MovieDTO.self) else {
            return true
        }
        let current = currentMovie.results ?? []
        let saved = savedMovies.results ?? []
        return !(saved.contains(current))
    }
}


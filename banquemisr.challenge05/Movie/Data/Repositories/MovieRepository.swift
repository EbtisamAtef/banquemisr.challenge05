//
//  MovieRepository.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation
import NetworkService


struct MovieRepository: MovieContract {
    
    private let apiClient: HttpClientProtocol
    
    init(apiClient: HttpClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getPopularMovies() async throws -> MovieDTO {
        let endpoint = MovieEndpoints.getPopularMovies
        return try await apiClient.performRequest(endpoint: endpoint, responseModel: MovieDTO.self)
    }
    
    func getNowPlayingMovies() async throws -> MovieDTO {
        let endpoint = MovieEndpoints.getNowPlayingMovies
        return try await apiClient.performRequest(endpoint: endpoint, responseModel: MovieDTO.self)
    }
    
    func getUpcomingMovies() async throws -> MovieDTO {
        let endpoint = MovieEndpoints.getUpcomingMovies
        return try await apiClient.performRequest(endpoint: endpoint, responseModel: MovieDTO.self)
    }
    
    func loadImage(url: URL) async throws -> Data  {
        return try await apiClient.loadImageData(from: url)
    }
}

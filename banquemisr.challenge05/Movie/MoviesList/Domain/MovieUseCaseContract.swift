//
//  MovieUseCaseContract.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation

protocol MovieUseCaseContract {
    func getPopularMovies() async throws -> MovieEntity
    func getNowPlayingMovies() async throws -> MovieEntity
    func getUpcomingMovies() async throws -> MovieEntity
    func loadImage(url: URL) async throws -> Data
}


//
//  MovieContract.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation

protocol MovieContract {
    func getPopularMovies() async throws -> MovieDTO
    func getNowPlayingMovies() async throws -> MovieDTO
    func getUpcomingMovies() async throws -> MovieDTO
    func loadImage(url: URL) async throws -> Data


}

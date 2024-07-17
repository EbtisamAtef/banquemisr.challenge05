//
//  MovieViewModelType.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation
import Combine

typealias MovieViewModelType = MovieViewModelInputType & MovieViewModelOutputType

protocol MovieViewModelInputType {}


protocol MovieViewModelOutputType {
    
    var popularMovieListPublisher: AnyPublisher<[MovieListEntity], Never> { get }
    var playingNowMovieListPublisher: AnyPublisher<[MovieListEntity], Never> { get }
    var upcomingMovieListPublisher: AnyPublisher<[MovieListEntity], Never> { get }

    
    func getPopularMovies()
    func getNowPlayingMovies()
    func getUpcomingMovies()
}

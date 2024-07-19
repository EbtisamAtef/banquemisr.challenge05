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
    var movieTypePublisher: AnyPublisher<MovieType, Never> { get }
    var loadedImagePublisher: AnyPublisher<Data?, Never> { get }
    var loadedImage: Data? { get }

    
    func featchMovieType()
    func getPopularMovies()
    func getNowPlayingMovies()
    func getUpcomingMovies()
    func getMovieListCount() -> Int
    func setMovitype(_ type: MovieType)
    func getMovieDetails(index: Int)-> MovieListEntity
    func navigateToMovieDetails(movieDetails: MovieListEntity)
    func loadImage(url: URL)
    

}

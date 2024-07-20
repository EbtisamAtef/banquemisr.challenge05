//
//  Mapper.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation
import NetworkService

struct Mapper {
    
    static func converMovieDTO(_ model: MovieDTO) -> MovieEntity {
        MovieEntity(page: model.page,
                    results: converMovieList(model.results ?? [])
        )
    }
    
    static func converMovieList(_ list: [MovieList]) -> [MovieListEntity] {
        list.map { movie in
            MovieListEntity(adult: movie.adult,
                            video: movie.video,
                            genreIds: movie.genre_ids,
                            id: movie.id,
                            voteCount: movie.vote_count,
                            backdropPath: movie.backdrop_path,
                            originalLanguage: movie.original_language,
                            originalTitle: movie.original_title,
                            overview: movie.overview,
                            posterPath: ApiConfig.shared.imageBaseUrl + (movie.poster_path ?? ""),
                            releaseDate: movie.release_date,
                            title: movie.title,
                            popularity: movie.popularity,
                            voteAverage: movie.vote_average)
        }
    }
}

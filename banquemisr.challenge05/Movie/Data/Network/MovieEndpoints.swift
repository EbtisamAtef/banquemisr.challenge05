//
//  MovieEndpoints.swift
//  banquemisr.challenge05
//
//  Created by mac on 17/07/2024.
//

import Foundation
import NetworkService

enum MovieEndpoints: EndPointProvider {
    
    case getPopularMovies
    case getNowPlayingMovies
    case getUpcomingMovies
    
    
    var path: String {
        switch self {
        case .getPopularMovies: return "/popular"
        case .getNowPlayingMovies: return "/now_playing"
        case .getUpcomingMovies: return "/upcoming"
            
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var mockFile: String? {
        switch self {
        case .getPopularMovies: return "popular-movies"
        case .getNowPlayingMovies: return "playing-now-movies"
        case .getUpcomingMovies: return "upcoming-movies"
        }
    }
    
    var bundle: Bundle {
        return Bundle(identifier: "com.Ebtisam.banquemisr-challenge05") ?? Bundle()
    }
    
}

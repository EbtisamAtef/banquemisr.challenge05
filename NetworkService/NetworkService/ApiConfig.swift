//
//  ApiConfig.swift
//  Network
//
//  Created by mac on 16/07/2024.
//

import Foundation

public class ApiConfig {
    
    public static var shared = ApiConfig()
    
    public var baseUrl = "https://api.themoviedb.org/3/movie"
    
    public var imageBaseUrl = "https://image.tmdb.org/t/p/w185/"
    
    public var token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkN2NiMTAwOTk4ZDlkOWYwZjJkMjg5ODg5OWY0Y2E4MSIsIm5iZiI6MTcyMTE1OTM2OS44MTA4MzQsInN1YiI6IjVjNGZmOTkwMGUwYTI2NDk1YWQ5NzY0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lcrbWsUcLGGkub_Qf3Ftxsz3CCxoGOEX1P05FVsdVyM"
}

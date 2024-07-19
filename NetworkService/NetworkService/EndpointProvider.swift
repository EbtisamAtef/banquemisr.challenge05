//
//  EndpointProvider.swift
//  Network
//
//  Created by mac on 16/07/2024.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol EndPointProvider {
    
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var token: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var mockFile: String? { get }

}

public extension EndPointProvider {
    
    var queryItems: [URLQueryItem]? { nil }
    
    var body: [String : Any]? { nil }
    
    var bundle: Bundle? {
        Bundle(identifier: "com.Ebtisam.banquemisr-challenge05") ?? Bundle()
    }
    
    var baseURL: String { ApiConfig.shared.baseUrl }
    
    var token: String { ApiConfig.shared.token }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: baseURL)!.appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let queryItems = queryItems {
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else {
            
            throw ApiErrorModel(
                statusCode: 0,
                statusMessage: "URL error",
                success: false
            )

        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !token.isEmpty {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw ApiErrorModel(
                    statusCode: 0,
                    statusMessage: "Error encoding HTTP body",
                    success: false
                )
            }
        }
        
        return urlRequest
    }
    
    
    
    
}

//
//  EndpointProvider.swift
//  Network
//
//  Created by mac on 16/07/2024.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol EndpointProvider {
    
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var token: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var mockFile: String? { get }
    var bundle: Bundle? { get }

}

extension EndpointProvider {
    
    var scheme: String {
        return ""
    }
    
    var baseURL: String {
        ApiConfig.shared.baseUrl
    }
    
    var token: String {
        ApiConfig.shared.token
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.path = path
        urlComponents.host = baseURL
        
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw ApiErrorModel(errorCode: "", message: "URL error")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")
        
        if !token.isEmpty {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw ApiErrorModel(errorCode: "0", message: "Error encoding http body")
            }
        }
        return urlRequest
    }
    
    
    
    
}

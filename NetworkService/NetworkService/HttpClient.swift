//
//  HttpClient.swift
//  Network
//
//  Created by mac on 16/07/2024.
//

import Foundation
import Combine
import Network


public protocol HttpClientProtocol {
    func performRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T
}

public final class HttpClient: HttpClientProtocol {
    
    public init() {}
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 300
        return URLSession(configuration: configuration)
    }
    
    public func performRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T {
        let connectivityStatus = await Reachability.checkNetworkConnectivity()
        if connectivityStatus.isConnected {
            do {
                let (data, response) = try await session.data(for: endpoint.asURLRequest())
                return try self.handleResponse(data: data, response: response)
            } catch let error as ApiErrorModel {
                throw error
            }
        } else {
            throw ApiErrorModel(
                statusCode: 0,
                statusMessage: "Lost internet connection",
                success: false
            )
        }
    }
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw ApiErrorModel(
                statusCode: 0,
                statusMessage: "Invalid HTTP response",
                success: false
            )
        }
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw ApiErrorModel(
                    statusCode: 0,
                    statusMessage:"Error decoding JSON: \(error.localizedDescription)",
                    success: false
                )
            }
        default:
            guard let decodedError = try? JSONDecoder().decode(ApiErrorModel.self, from: data) else {
                throw ApiErrorModel(
                    statusCode: response.statusCode,
                    statusMessage: "Unknown backend error",
                    success: false
                )
            }
            throw ApiErrorModel(
                statusCode: response.statusCode,
                statusMessage: decodedError.statusMessage,
                success: false
            )
        }
    }
}





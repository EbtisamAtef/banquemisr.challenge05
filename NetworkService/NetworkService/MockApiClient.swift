//
//  MockApiClient.swift
//  Network
//
//  Created by mac on 16/07/2024.
//

import Foundation


public class MockApiClient: HttpClientProtocol {
       
    public var sendError: Bool
    public  var mockFile: String?
    
    public init(sendError: Bool = false, mockFile: String? = nil) {
        self.sendError = sendError
        self.mockFile = mockFile
    }
    
    private func loadJSON<T: Decodable>(filename: String, type: T.Type, bundle: Bundle) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)
            
            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
    
    
    public func performRequest<T>(endpoint: EndPointProvider, responseModel: T.Type) async throws -> T where T: Decodable {

        if sendError {
            throw ApiErrorModel(statusCode: 0, statusMessage: "Async Failed", success: false)
        } else {
            return loadJSON(filename: endpoint.mockFile!,
                            type: responseModel.self,
                            bundle: endpoint.bundle ?? Bundle())
                            
                            }
    }
    
    public func loadImageData(from url: URL) async throws -> Data {
        return Data()
    }
    
}

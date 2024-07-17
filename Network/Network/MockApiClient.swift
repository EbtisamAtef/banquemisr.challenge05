//
//  MockApiClient.swift
//  Network
//
//  Created by mac on 16/07/2024.
//

import Foundation


class MockApiClient: ApiProtocol {
    
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

    
    func asyncRequest<T>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T where T: Decodable {
        return loadJSON(filename: endpoint.mockFile!,
                        type: responseModel.self,
                        bundle: endpoint.bundle ?? Bundle(for: type(of: self)))
    }
    
}

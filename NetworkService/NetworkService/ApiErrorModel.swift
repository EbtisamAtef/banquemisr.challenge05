//
//  ApiErrorModel.swift
//  Network
//
//  Created by mac on 16/07/2024.
//

import Foundation

public struct ApiErrorModel: Error {
    
    public var statusCode: Int?
    public var statusMessage: String?
    public var success: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case statusCode = "status_Code"
        case statusMessage = "status_message"
        case success = "success"
    }
}

extension ApiErrorModel: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try container.decode(Int.self, forKey: .statusCode)
        statusMessage = try container.decode(String.self, forKey: .statusMessage)
        success = try container.decode(Bool.self, forKey: .success)

    }
    
}

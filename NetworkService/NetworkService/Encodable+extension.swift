//
//  Encodable+extension.swift
//  NetworkService
//
//  Created by mac on 16/07/2024.
//

import Foundation

extension Encodable {

    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}


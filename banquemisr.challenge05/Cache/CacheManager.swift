//
//  File.swift
//  banquemisr.challenge05
//
//  Created by mac on 19/07/2024.
//

import Foundation


class CacheManager {
    
    static let shared = CacheManager()
    
    private init() {}
    

    func saveToFile<T: Codable>(_ object: T, fileName: String) {
        let encoder = JSONEncoder()
        do {
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            let data = try encoder.encode(object)
            try data.write(to: fileURL)
            print("Data saved to \(fileURL)")
        } catch {
            print("Error saving data to file: \(error)")
        }
    }
    
    func retrieveFromFile<T: Codable>(fileName: String, as type: T.Type) -> T? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print("Error retrieving data from file: \(error)")
            return nil
        }
        
    }
    

    func deleteFromFile(fileName: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("File deleted from \(fileURL)")
        } catch {
            print("Error deleting file: \(error)")
        }
    }


    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

}


//
//  FileReader.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import Foundation

class FileReader {
    static func decode<T: Decodable>(fromFile fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                 do {
                     let data = try Data(contentsOf: url)
                     let decoder = JSONDecoder()
                     let decodedData = try decoder.decode(T.self, from: data)
                     return decodedData
                 } catch {
                     print("Failed to load or parse JSON: \(error)")
                 }
             }
             return nil
    }
}


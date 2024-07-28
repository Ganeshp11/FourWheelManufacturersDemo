//
//  FileReader.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import Foundation

struct FileReader {
    func decode<T: Decodable>(fromFile fileName: String, type: String) throws -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: type) else {
            throw FileReaderError.invalidPath
         }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(T.self, from: data)
            return  response
        } catch let error {
            print(error)
            throw FileReaderError.contentError
        }
    }
}


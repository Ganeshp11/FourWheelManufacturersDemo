//
//  CarBrandModel.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import Foundation
                
struct CarBrandResponse: Decodable {
    let brands: [Brand]?
    enum CodingKeys: String, CodingKey {
        case brands = "carBrands"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.brands = try container.decodeIfPresent([Brand].self, forKey: .brands)
    }
}

struct Brand: Decodable {
    let id: Int?
    let name: String?
    let manufacturer: String?
    let cars: [Car]?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "brandName"
        case manufacturer = "manufacturer"
        case cars = "models"
        case imageUrl = "imageUrl"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.manufacturer = try container.decodeIfPresent(String.self, forKey: .manufacturer)
        self.cars = try container.decodeIfPresent([Car].self, forKey: .cars)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
    }
}

struct Car: Decodable {
    let id: Int?
    let name: String?
    let imageUrl: String?
    let price: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "modelName"
        case imageUrl = "imageUrl"
        case price = "price"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.price = try container.decodeIfPresent(String.self, forKey: .price)
    }
}

struct CharacterCount {
    let character: Character?
    let count: Int?
}

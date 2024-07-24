//
//  CarBrandModel.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import Foundation

struct CarBrandResponse: Codable {
    let carBrands: [CarBrand]?
}

struct CarBrand: Codable {
    let id: String?
    let brandName: String?
    let manufacturer: String?
    let models: [CarModel]?
    let imageUrl: String?
}

struct CarModel: Codable {
    let id: String?
    let modelName: String?
    let imageUrl: String?
    let price: String?
}

//
//  VehicleBrandProtocol.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 24/07/24.
//

import Foundation

protocol CarBrandViewModelProtocol {
    func getVehicles()
    func searchVehicles(searchText: String)
    func getVehiclesById(vehicleId: Int)
    func clearVehicleSearch()
    func getStatistics()
    var brands: [Brand] {get}
    var cars: [Car] {get}
    var delegate: CarBrandViewModelDelegate? {get set}
}

protocol CarBrandViewModelDelegate: AnyObject {
    func didFinishVehicleLoading()
    func didFailVehicleLoading(error: String)
    func didUpdateStatistics(modelCounts: [String: Int], characterCounts: [CharacterCount])
}

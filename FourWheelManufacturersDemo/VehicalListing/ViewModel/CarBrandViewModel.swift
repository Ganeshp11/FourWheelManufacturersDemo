//
//  CarBrandViewModel.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import Foundation

class CarBrandViewModel {
    var carBrands: [CarBrand] = []
    var filteredCarModels: [CarModel] = []
    var selectedCarBrand: CarBrand?
    var searchText: String = "" {
        didSet {
            filterModels()
        }
    }
    
    init() {
        loadCarBrands()
        filterModels()
    }
    
    private func loadCarBrands() {
        if let carBrandResponse: CarBrandResponse = FileReader.decode(fromFile: "CarBrands", type: CarBrandResponse.self) {
            carBrands = carBrandResponse.carBrands ?? []
            selectedCarBrand = carBrands.first
            filteredCarModels = selectedCarBrand?.models ?? []
        }
    }
    func filterModels() {
      if let selectedCarBrand = selectedCarBrand, let models = selectedCarBrand.models {
        if searchText.isEmpty {
          filteredCarModels = models
        } else {
          filteredCarModels = models.filter { model in
            model.modelName?.lowercased().contains(searchText.lowercased()) ?? false
          }
        }
      } else {
        filteredCarModels = []
      }
    }
 
    func getCarBrand(at index: Int) -> CarBrand? {
        guard index >= 0 && index < carBrands.count else {
            return nil
        }
        return carBrands[index]
    }
    
    func selectCarBrand(at index: Int) {
        selectedCarBrand = getCarBrand(at: index)
        filterModels()
    }
}

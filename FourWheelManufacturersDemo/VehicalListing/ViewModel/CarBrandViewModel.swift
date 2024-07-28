//
//  CarBrandViewModel.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import Foundation

class CarBrandViewModel: CarBrandViewModelProtocol   {
    weak var delegate: CarBrandViewModelDelegate?
    var brands: [Brand] = []
    var cars: [Car] = []
    private var selectedBrand: Brand?
    private var fileReader: FileReader
    
    init(fileReader: FileReader = FileReader()) {
        self.fileReader = fileReader
    }
    
    func getVehicles() {
        do {
            let response:CarBrandResponse =  try fileReader.decode(fromFile: "CarBrands", type: "json")
            brands = response.brands ?? []
            setCarData()
        } catch (let error) {
            delegate?.didFailVehicleLoading(error: error.localizedDescription)
        }
    }
    
    func searchVehicles(searchText: String) {
        if searchText.isEmpty {
            setCarData()
        } else {
            cars = selectedBrand?.cars?.filter { model in
                return model.name?.lowercased().range(of: searchText.lowercased()) != nil
            } ?? []
            updateCarData(isSearching: true)
        }
    }
    
    func getVehiclesById(vehicleId: Int) {
        selectedBrand = brands.filter({$0.id == vehicleId}).first
        cars = selectedBrand?.cars ?? []
        updateCarData()
    }
    
    func clearVehicleSearch() {
        setCarData()
    }
    
    private func setCarData() {
        selectedBrand = brands.first
        cars = selectedBrand?.cars ?? []
        updateCarData()
    }
    
    private func updateCarData(isSearching: Bool = false) {
        if cars.isEmpty {
            delegate?.didFailVehicleLoading(error: isSearching ? FileReaderError.noSearchItem.localizedDescription : FileReaderError.noData.localizedDescription)
        } else {
            delegate?.didFinishVehicleLoading()
        }
    }
}

extension CarBrandViewModel {
    func getStatistics() {
        var modelCounts: [String: Int] = [:]
        var characterCounts: [Character: Int] = [:]
        modelCounts[selectedBrand?.name ?? ""] = selectedBrand?.cars?.count ?? 0
        
        let allowedCharacters = CharacterSet.letters.union(.decimalDigits)
        
        for car in selectedBrand?.cars ?? [] {
            for char in car.name?.lowercased() ?? "" {
                if let scalar = char.unicodeScalars.first, allowedCharacters.contains(scalar) {
                    characterCounts[char, default: 0] += 1
                }
            }
        }
        let sortedCharacterCounts = characterCounts.sorted { (first, second) -> Bool in
            if first.value == second.value {
                return first.key < second.key
            }
            return first.value > second.value
        }
            .map { CharacterCount(character: $0.key, count: $0.value) }
            .prefix(3)
        delegate?.didUpdateStatistics(modelCounts: modelCounts, characterCounts: Array(sortedCharacterCounts))
    }
}

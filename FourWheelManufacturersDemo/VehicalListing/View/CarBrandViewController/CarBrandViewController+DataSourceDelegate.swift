//
//  CarBrandViewController+DataSourceDelegate.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 24/07/24.
//

import Foundation
import  UIKit

extension CarBrandViewController: UITableViewDataSource {
    //MARK: - TableView Delegate and DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.carModelListIdentifier, for: indexPath) as? CarModelList
        cell?.setData(car: viewModel.cars[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension CarBrandViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellIdentifiers.tableHeaderIdentifier) as? TableHeaderSearchView
        header?.searchDelegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
}

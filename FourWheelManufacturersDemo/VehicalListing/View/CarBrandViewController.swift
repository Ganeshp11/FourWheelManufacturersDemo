//
//  ViewController.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import UIKit

class CarBrandViewController: UIViewController {
    
    //MARK: - @IBOutlet & Variables
    
    @IBOutlet weak var carBrandTableView: UITableView!
    
    var tableHeaderView: CarBrandHeader = .fromNib()
    private var viewModel: CarBrandViewModel!
    var selectedCarBrand: CarBrand?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CarBrandViewModel()
        setupTableView()
    }
    
    //MARK: - Setup Methods
    
    func setupTableView() {
        carBrandTableView.delegate = self
        carBrandTableView.dataSource = self
        carBrandTableView.register(UINib(nibName: "CarModelList", bundle: nil),
                                   forCellReuseIdentifier: "CarModelList")
        carBrandTableView.register(UINib(nibName: "TableHeaderSearchView", bundle: nil), forHeaderFooterViewReuseIdentifier: "TableHeaderSearchView")
        carBrandTableView.tableHeaderView = tableHeaderView
        setupTableViewHeader()
    }
    
    func setupTableViewHeader() {
        tableHeaderView.frame.size.height = 150
        tableHeaderView.setupData(with: viewModel.carBrands)
        tableHeaderView.didSelectCarBrand = { [weak self] carBrand in
            self?.viewModel.selectedCarBrand = carBrand
            self?.viewModel.filterModels()
            self?.carBrandTableView.reloadData()
        }
    }
}
extension CarBrandViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView Delegate and DataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCarModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarModelList") as! CarModelList
        
        let carModel = viewModel.filteredCarModels[indexPath.row]
        let imgName = carModel.imageUrl
        cell.carImage.image = UIImage(named: imgName ?? "")
        cell.carName.text = carModel.modelName
        cell.manufactureName.text = "Price: Rs." + (carModel.price ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderSearchView") as! TableHeaderSearchView
        header.searchBar.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
}
extension CarBrandViewController: UISearchBarDelegate {
    //MARK: - SearchBar Delegate Methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        carBrandTableView.reloadData()
    }
    
}


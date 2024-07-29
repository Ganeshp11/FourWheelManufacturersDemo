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
    @IBOutlet weak var bottomSheetBtn: UIButton!
    
    private var tableHeaderView: CarBrandHeader = .fromNib()
    private var selectedCarBrand: Brand?
    
    var viewModel: CarBrandViewModelProtocol = CarBrandViewModel()
    let noDataLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBottomSheetBtn()
        setupViewModel()
    }
    
    //MARK: - Setup Methods
    private func setupTableView() {
        carBrandTableView.sectionHeaderTopPadding = 0
        carBrandTableView.delegate = self
        carBrandTableView.dataSource = self
        carBrandTableView.register(UINib(nibName: CellIdentifiers.carModelListIdentifier, bundle: nil),forCellReuseIdentifier: CellIdentifiers.carModelListIdentifier)
        setupTableViewHeader()
    }
    
    private func setupBottomSheetBtn() {
        bottomSheetBtn.setTitle("", for: .normal)
        bottomSheetBtn.addTarget(self, action: #selector(showStatistics), for: .touchUpInside)
    }
    
    private func setupTableViewHeader() {
        carBrandTableView.register(UINib(nibName: CellIdentifiers.tableHeaderIdentifier, bundle: nil),
                                   forHeaderFooterViewReuseIdentifier: CellIdentifiers.tableHeaderIdentifier)
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 150)
        tableHeaderView.delegate = self
        carBrandTableView.tableHeaderView = tableHeaderView
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.getVehicles()
    }
}

//MARK: - SearchBar Delegate Methods
extension CarBrandViewController: CustomSearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchVehicles(searchText: searchText)
    }
    
    func searchBarTextDidChange(_ searchText: String) {
        viewModel.searchVehicles(searchText: searchText)
    }
    func searchBarCancelButtonClicked() {
        viewModel.clearVehicleSearch()
    }
}

//MARK: - CarBrandViewModel Delegate Methods
extension CarBrandViewController: CarBrandViewModelDelegate {
    
    func didFinishVehicleLoading() {
        DispatchQueue.main.async {
            self.carBrandTableView.backgroundView = nil
            self.tableHeaderView.setupData(with: self.viewModel.brands)
            self.carBrandTableView.reloadData()
        }
    }
    
    func didFailVehicleLoading(error: String) {
        noDataLabel.text = error
        carBrandTableView.backgroundView = noDataLabel
        self.carBrandTableView.reloadData()
    }
}

//MARK: - CarBrandHeader Delegate Methods
extension CarBrandViewController: CarBrandHeaderDelegate {
    func selectedBrandId(id: Int) {
        viewModel.getVehiclesById(vehicleId: id)
    }
}

extension CarBrandViewController {
    @objc private func showStatistics() {
        viewModel.getStatistics()
    }
    
    func didUpdateStatistics(modelCounts: [String: Int], characterCounts: [CharacterCount]) {
        let statisticsVC = StatisticsViewController(nibName: "StatisticsViewController", bundle: nil)
        
        if let sheet = statisticsVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 25
        }
        statisticsVC.configure(modelCounts: modelCounts, characterCounts: characterCounts)
        present(statisticsVC, animated: true, completion: nil)
    }
}

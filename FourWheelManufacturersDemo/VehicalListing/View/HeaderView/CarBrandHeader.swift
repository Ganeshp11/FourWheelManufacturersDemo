//
//  CarBrandHeader.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import UIKit

protocol CarBrandHeaderDelegate: AnyObject {
    func selectedBrandId(id: Int)
}

class CarBrandHeader: UITableViewHeaderFooterView {
    
    //MARK: - @IBOutlet & Variables
    
    @IBOutlet weak var carBrandCollection: UICollectionView!
    @IBOutlet weak var pagerController: UIPageControl!
    private var brandList: [Brand] = []
    weak var delegate: CarBrandHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }
    
    private func setupCollection() {
        carBrandCollection.register(UINib(nibName: CellIdentifiers.collectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.collectionViewCell)
        let layout = CustomFlowLayout()
        carBrandCollection.setCollectionViewLayout(layout, animated: false)
        carBrandCollection.decelerationRate = .fast
        carBrandCollection.dataSource = self
        carBrandCollection.delegate = self
        carBrandCollection.isPagingEnabled = true
        pagerController.numberOfPages = 0
    }
    
    func setupData(with carBrands: [Brand]) {
        self.brandList = carBrands
        carBrandCollection.reloadData()
        pagerController.numberOfPages = carBrands.count
    }
    private func setupCollectionViewCell() {
        carBrandCollection.reloadData()
        pagerController.numberOfPages = brandList.count
    }
}

extension CarBrandHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.collectionViewCell, for: indexPath) as! CarBrandsCollectionCell
        cell.strImage = brandList[indexPath.row].imageUrl
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + scrollView.bounds.width / 2, y: scrollView.bounds.height / 2)
        if let indexPath = carBrandCollection.indexPathForItem(at: center), let id = brandList[indexPath.item].id {
            pagerController.currentPage = indexPath.item
            delegate?.selectedBrandId(id: id)
        }
    }
    
}

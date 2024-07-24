//
//  CarBrandHeader.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import UIKit

class CarBrandHeader: UITableViewHeaderFooterView {
    
    //MARK: - @IBOutlet & Variables

    @IBOutlet weak var carBrandCollection: UICollectionView!
    @IBOutlet weak var pagerController: UIPageControl!
    
    var didSelectCarBrand: ((CarBrand) -> Void)?
    var brandList: [CarBrand] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
        setupPageControl()
    }
    
    private func setupCollection() {
        carBrandCollection.register(UINib(nibName: "CarBrandsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CarBrandsCollectionCell")
        let layout = CustomFlowLayout()
        carBrandCollection.setCollectionViewLayout(layout, animated: false)
        carBrandCollection.decelerationRate = .fast
        carBrandCollection.dataSource = self
        carBrandCollection.delegate = self
        carBrandCollection.isPagingEnabled = true
        setupCollectionViewCell()
        
    }
    func setupData(with carBrands: [CarBrand]) {
            self.brandList = carBrands
        carBrandCollection.reloadData()
            pagerController.numberOfPages = carBrands.count
        }
    private func setupCollectionViewCell() {
        carBrandCollection.reloadData()
        pagerController.numberOfPages = brandList.count
    }
    private func setupPageControl() {
        pagerController.numberOfPages = brandList.count
    }
}

extension CarBrandHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarBrandsCollectionCell", for: indexPath) as! CarBrandsCollectionCell
        let index = indexPath.row
        let list = brandList[index]
        let image = list.imageUrl
        cell.strImage = image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let carBrand = brandList[indexPath.row]
        didSelectCarBrand?(carBrand)
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + scrollView.bounds.width / 2, y: scrollView.bounds.height / 2)
        if let indexPath = carBrandCollection.indexPathForItem(at: center) {
            pagerController.currentPage = indexPath.item
            didSelectCarBrand?(brandList[indexPath.item])
        }
    }
    
}

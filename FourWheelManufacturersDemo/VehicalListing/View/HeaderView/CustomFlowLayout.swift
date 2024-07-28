//
//  collectionViewLayout.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let itemWidth = collectionView.frame.width
        itemSize = CGSize(width: itemWidth, height: collectionView.frame.height)
        scrollDirection = .horizontal
        minimumLineSpacing = 0
    }
    
}

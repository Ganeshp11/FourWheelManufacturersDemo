//
//  CarBrandsCollectionCell.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import UIKit

class CarBrandsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var brandImage: UIImageView!
    
    var strImage: String?  {
        didSet {
            setupCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    
    private func setupCell() {
        let name = strImage ?? ""
        brandImage.image = UIImage(named: name)
    }
}

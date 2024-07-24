//
//  CarModelList.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import UIKit

class CarModelList: UITableViewCell {

    //MARK: - @IBOutlet & Variables

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var manufactureName: UILabel!
    @IBOutlet weak var cellBackground: UIView!
    
    var carData: CarModel?  {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        // Initialization code
    }
    private func setupCell() {
        cellBackground.setCorner(radius: 8, borderWidth: 1, borderColor: .lightText)
        carName.text = carData?.modelName ?? ""
        
        if let imgName = carData?.imageUrl {
            carImage.image = UIImage(named: imgName)
        } else {
            carImage.image = nil
        }
    }
    
}

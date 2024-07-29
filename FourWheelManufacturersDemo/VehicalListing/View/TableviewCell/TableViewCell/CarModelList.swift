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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(car: Car) {
        cellBackground.setCorner(radius: SizeConstants.radius, borderWidth: SizeConstants.borderWidth, borderColor: .lightText)
        carName.text = car.name ?? ""
        manufactureName.text = StringConstants.rs + (car.price ?? "")
        carImage.image = UIImage(named: car.imageUrl ?? "")
    }
}

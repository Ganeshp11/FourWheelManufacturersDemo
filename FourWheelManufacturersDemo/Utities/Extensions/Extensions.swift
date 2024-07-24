//
//  Extensions.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 20/07/24.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    func setCorner(radius:CGFloat,borderWidth:CGFloat,borderColor: UIColor)  {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
}

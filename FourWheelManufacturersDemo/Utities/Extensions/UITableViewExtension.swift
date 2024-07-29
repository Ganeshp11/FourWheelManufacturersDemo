//
//  UITableViewExtension.swift
//  FourWheelManufacturersDemo
//
//  Created by Neosoft on 29/07/24.
//

import Foundation
import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(withClass cellClass: T.Type) -> T {
        let identifier = String(describing: cellClass)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError("Error: could not dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(cellClass: T.Type) {
        let identifier = String(describing: cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
}

//
//  UICollectionView+Extension.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 10/09/2022.
//

import UIKit

protocol IdentifierReusable {
    static var identifier: String { get }
}

extension IdentifierReusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: IdentifierReusable { }

extension UICollectionView {
    public func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }
}

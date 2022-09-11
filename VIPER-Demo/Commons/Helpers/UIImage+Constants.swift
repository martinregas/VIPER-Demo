//
//  Images.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 10/09/2022.
//

import Foundation

import UIKit

extension UIImage {
    static var backgroundList: UIImage { #function.namedImage() }
    static var backgroundDetail: UIImage { #function.namedImage() }
    static var placeholder: UIImage { #function.namedImage() }
    static var portal: UIImage { #function.namedImage() }
}

private extension String {
    func namedImage() -> UIImage {
        return UIImage(named: self) ?? UIImage()
    }
}


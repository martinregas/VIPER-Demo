//
//  FadeCollectionView.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import UIKit

class FadeCollectionView: UICollectionView {
    private let fadePercentage: Double = 0.015
    private let gradientLayer = CAGradientLayer()
    private let opaqueColor = UIColor.black.cgColor
    private var lastContentOffset: CGPoint = .zero
        
    var topOpacity: CGColor {
        
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset <= 0) ? 1 : 0
        
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    var bottomOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset + scrollViewHeight >= scrollContentSizeHeight) ? 1 : 0

        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds
        
        gradientLayer.frame = CGRect(x: self.bounds.origin.x, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        gradientLayer.colors = [topOpacity, opaqueColor, opaqueColor, bottomOpacity]
        gradientLayer.locations = [0, NSNumber(floatLiteral: fadePercentage), NSNumber(floatLiteral: 1 - fadePercentage), 1]
        maskLayer.addSublayer(gradientLayer)
        
        self.layer.mask = maskLayer
    }
}

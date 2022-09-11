//
//  StrokedLabel.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 08/09/2022.
//

import UIKit

public class StrokedLabel: UILabel{    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = .font(name: .primary, size: fontSize)
    }
    
    public override var intrinsicContentSize : CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width, height: size.height + 20)
    }

    override public func drawText(in rect: CGRect) {
        let shadowOffset = self.shadowOffset

        let c = UIGraphicsGetCurrentContext()
        c?.setLineWidth(6)
        c?.setLineJoin(.round)
        c?.setTextDrawingMode(.stroke)
        self.textColor = .limeGreen
        super.drawText(in:rect)
        
        c?.setTextDrawingMode(.fill)

        let d = UIGraphicsGetCurrentContext()
        d?.setLineWidth(2)
        d?.setLineJoin(.round)
        d?.setTextDrawingMode(.stroke)
        self.textColor = .darkBlue
        super.drawText(in:rect)
        
        d?.setTextDrawingMode(.fill)

        self.textColor = .lightBlue
        self.shadowOffset = shadowOffset
        super.drawText(in:rect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

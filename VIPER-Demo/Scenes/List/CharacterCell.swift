//
//  CharacterCell.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    private var imageView = UIImageView()
        
    private var gradientView = UIView()
    
    private var gradient = CAGradientLayer()
    
    private let nameLabel: StrokedLabel  = {
        let label = StrokedLabel(fontSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        configureConstraints()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradient.frame = gradientView.bounds
    }

    private func configureUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(nameLabel)

        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        
        contentView.layer.borderColor = UIColor.limeGreen.cgColor
        contentView.layer.borderWidth = 1
        
        setGradient()
    }
    
    private func setGradient() {
        gradient.colors = [UIColor.black.withAlphaComponent(0.0).cgColor,
                                UIColor.black.withAlphaComponent(1.0).cgColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientView.layer.insertSublayer(gradient, at: 0)
    }

    private func configureConstraints() {
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        nameLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5))
        gradientView.anchor(top: centerYAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: -50, left: 0, bottom: 0, right: 0))
    }
    
    func configure(name: String, image: String, status: String) {
        imageView.load(url: image, placeholder: .placeholder)
        nameLabel.text = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

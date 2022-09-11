//
//  InfoView.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 09/09/2022.
//

import UIKit

class InfoView: UIView {
    private var backgroundView = UIView()
    
    private var charStackView = UIStackView()
    private var locStackView = UIStackView()
    
    private var locNameTitleLabel = UILabel()
    private var locTypeTitleLabel = UILabel()
    private var locDimensionTitleLabel = UILabel()
    
    private var locNameLabel = UILabel()
    private var locTypeLabel = UILabel()
    private var locDimensionLabel = UILabel()
    
    private var statusTitleLabel = UILabel()
    private var speciesTitleLabel = UILabel()
    private var genderTitleLabel = UILabel()
    
    private var statusLabel = UILabel()
    private var speciesLabel = UILabel()
    private var genderLabel = UILabel()
    
    private var locationTitleLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        backgroundColor = .clear
        
        backgroundView.backgroundColor = .black.withAlphaComponent(0.75)
        backgroundView.layer.cornerRadius = 15
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.borderColor = UIColor.limeGreen.cgColor
        backgroundView.layer.borderWidth = 1
        
        let statusStackView = prepareInfoLabels(titleLabel: statusTitleLabel, dataLabel: statusLabel)
        let speciesStackView = prepareInfoLabels(titleLabel: speciesTitleLabel, dataLabel: speciesLabel)
        let typeStackView = prepareInfoLabels(titleLabel: genderTitleLabel, dataLabel: genderLabel)
        
        charStackView.axis = .vertical
        charStackView.alignment = .leading
        charStackView.spacing = 5
        charStackView.addArrangedSubview(statusStackView)
        charStackView.addArrangedSubview(speciesStackView)
        charStackView.addArrangedSubview(typeStackView)
        
        configureTitleLabel(label: locationTitleLabel)
        backgroundView.addSubview(locationTitleLabel)
        
        let locNameStackView = prepareInfoLabels(titleLabel: locNameTitleLabel, dataLabel: locNameLabel)
        let locTypeStackView = prepareInfoLabels(titleLabel: locTypeTitleLabel, dataLabel: locTypeLabel)
        let locDimensionStackView = prepareInfoLabels(titleLabel: locDimensionTitleLabel, dataLabel: locDimensionLabel)
        
        locStackView.axis = .vertical
        locStackView.alignment = .leading
        locStackView.spacing = 5
        locStackView.addArrangedSubview(locationTitleLabel)
        locStackView.addArrangedSubview(locNameStackView)
        locStackView.addArrangedSubview(locTypeStackView)
        locStackView.addArrangedSubview(locDimensionStackView)
        
        backgroundView.addSubview(charStackView)
        backgroundView.addSubview(locStackView)
                
        addSubview(backgroundView)
    }
    
    private func configureConstraints() {
        backgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        charStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10))
        locStackView.anchor(top: charStackView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10))
    }
    
    private func prepareInfoLabels(titleLabel: UILabel, dataLabel: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .leading
        
        configureTitleLabel(label: titleLabel)
        configureDataLabel(label: dataLabel)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dataLabel)
        
        return stackView
    }
    
    private func configureDataLabel(label: UILabel) {
        label.textColor = .white
        label.font = .font(name: .secondary, size: 16)
    }
    
    private func configureTitleLabel(label: UILabel) {
        label.textColor = .white
        label.font = .font(name: .secondaryBold, size: 16)
    }
    
    func configure(character: Character, location: Location? = nil) {
        statusLabel.text = character.status
        speciesLabel.text = character.species
        genderLabel.text = character.gender
        
        statusTitleLabel.text = "Status:"
        speciesTitleLabel.text = "Species:"
        genderTitleLabel.text = "Gender:"
        
        if let location = location {
            locationTitleLabel.text = "LOCATION"
            
            locNameTitleLabel.text = "Name:"
            locTypeTitleLabel.text = "Type:"
            locDimensionTitleLabel.text = "Dimension:"
            
            locNameLabel.text = location.name
            locTypeLabel.text = location.type
            locDimensionLabel.text = location.dimension
        }
    }
}

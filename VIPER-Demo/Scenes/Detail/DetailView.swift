//
//  DetailView.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import UIKit

protocol DetailViewProtocol {
    var presenter: DetailPresenterProtocol? { get set }
    
    func update()
    func update(with error: String)
}


class DetailViewController: UIViewController, DetailViewProtocol{
    var presenter: DetailPresenterProtocol?
    
    private var imageView = AsyncImageView()
    
    private var containerView = UIView()
    
    private var contentView = UIView()
    
    private var backgroundView = UIImageView()
    
    private var infoView = InfoView()
    
    private var imageTopConstraint:NSLayoutConstraint?
    
    private let nameLabel: StrokedLabel  = {
        let label = StrokedLabel(fontSize: 28)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getCharacterLocation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.backgroundColor = .clear
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func configureConstraints() {
        containerView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: view.frame.height/1.2))
        containerView.centerInSuperview()
        
        backgroundView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
        
        contentView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)

        nameLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10))

        imageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width/2, height: view.frame.width/2))
        imageView.centerXInSuperview()

        imageTopConstraint = imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: view.frame.height*0.3)
        imageTopConstraint?.isActive = true
        
        infoView.anchor(top: imageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20))
    }
    
    private func configureUI() {
        view.backgroundColor = .clear
        
        imageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        nameLabel.alpha = 0
        infoView.alpha = 0

        guard let character = presenter?.character else { return }
        imageView.load(url: character.image, placeholder: .placeholder)
        nameLabel.text = character.name
        
        imageView.layer.cornerRadius = view.frame.width/4
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.limeGreen.cgColor
        imageView.layer.borderWidth = 1
        
        backgroundView.image = .backgroundDetail
        
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
                
        containerView.addSubview(backgroundView)
        containerView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoView)

        view.addSubview(containerView)
    }
    
    private func updateView(character: Character, location: Location? = nil) {
        infoView.configure(character: character, location: location)
        DispatchQueue.main.async {
            self.animateImage()
        }
    }
    
    private func animateImage() {
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
            self.imageView.transform = self.view.transform.rotated(by: CGFloat(Double.pi))
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.imageTopConstraint?.constant = 10
            self.view.layoutIfNeeded()
            self.view.backgroundColor = .black.withAlphaComponent(0.5)
        }, completion: { _ in
            self.animateInfo()
        })
    }
    
    private func animateInfo() {
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
            self.nameLabel.alpha = 1
            self.infoView.alpha = 1
        })
    }
    
    func update() {
        guard let character = presenter?.character, let location = presenter?.location else { return }
        updateView(character: character, location: location)
    }
    
    func update(with error: String) {
        print(error)
        guard let character = presenter?.character else { return }
        updateView(character: character)
    }
}

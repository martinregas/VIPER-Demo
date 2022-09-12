//
//  ListView.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    var presenter: ListPresenterProtocol? { get set }
    
    func update()
    func update(with error: String)
}

class ListViewController: UIViewController, ListViewProtocol {
    var presenter: ListPresenterProtocol?
    
    var bgView = UIImageView()
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.2, 1.0]
        bounceAnimation.duration = TimeInterval(0.2)
        bounceAnimation.calculationMode = .cubic
        return bounceAnimation
    }()
    
    private let topPortal: UIImageView  = {
        let portal = UIImageView(image: .portal)
        return portal

    }()
    
    private let bottomPortal: UIImageView  = {
        let portal = UIImageView(image: .portal)
        return portal
    }()
            
    var collectionView: FadeCollectionView!
    
    var collectionViewLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top:0, leading: 15, bottom: 0, trailing: 15)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0) , heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item,count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 30
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }

    private func configureUI() {
        collectionView = FadeCollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.register(cellClass: CharacterCell.self)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(bgView)
        view.addSubview(topPortal)
        view.addSubview(bottomPortal)
        view.addSubview(collectionView)
 
        bgView.image = .backgroundList
    }
    
    private func configureConstraints() {
        topPortal.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 50))
        collectionView.anchor(top: topPortal.centerYAnchor, leading: view.leadingAnchor, bottom: bottomPortal.centerYAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        bottomPortal.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 50))
        bgView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    private func animatePortal(for indexPath: IndexPath) {
        guard let firstCell = collectionView.visibleCells.first else { return }
                
        if let firstIndexPath = collectionView.indexPath(for: firstCell) {
            let portal = firstIndexPath > indexPath ? topPortal : bottomPortal
            portal.layer.add(bounceAnimation, forKey: nil)
        }
    }
    
    func update() {
        collectionView.reloadData()
    }
    
    func update(with error: String) {
        print(error)
    }
}

extension ListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.characters.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else { return UICollectionViewCell() }
        
        let character = presenter.characters[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath)

        if let cell = cell as? CharacterCell {
            cell.configure(name: character.name, image: character.image, status: character.status)
            return cell
        }
        
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter = presenter else { return }
        let character = presenter.characters[indexPath.row]
        
        let router = DetailRouter.start(with: character)
        
        guard let view = router.view else { return }
        
        guard let selectedCell = collectionView.cellForItem(at: indexPath),
              let originFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else {
            return
        }
        
        presenter.router?.present(view: view, originFrame: originFrame)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.willDisplay(indexPath.item)
        animatePortal(for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        animatePortal(for: indexPath)
    }
}

//
//  ListPresenter.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import Foundation

protocol ListPresenterProtocol: AnyObject {
    var router: ListRouterProtocol? { get set }
    var interactor: ListInteractorProtocol? { get set }
    var view: ListViewProtocol? { get set }
    
    var characters: [Character] { get }
    
    func willDisplay(_ index: Int)
    func interactorDidFetchCharacters(with result: Result<[Character], Error>)
}

class ListPresenter: ListPresenterProtocol {
    var router: ListRouterProtocol?
    
    weak var view: ListViewProtocol?
    
    var interactor: ListInteractorProtocol? {
        didSet {
            interactor?.getCharacters()
        }
    }
    
    var characters: [Character] = []
    
    func willDisplay(_ index: Int) {
        if index == characters.count - 8 {
            interactor?.getCharacters()
        }
    }
    
    func interactorDidFetchCharacters(with result: Result<[Character], Error>) {
        switch result {
        case .success(let characters):
            self.characters.append(contentsOf: characters)
            view?.update()
        case .failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
}

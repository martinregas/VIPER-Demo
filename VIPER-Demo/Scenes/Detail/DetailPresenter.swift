//
//  DetailPresenter.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 08/09/2022.
//

import Foundation

protocol DetailPresenterProtocol {
    var router: DetailRouterProtocol? { get set }
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }

    var character: Character? { get set }
    var location: Location? { get set }
    
    func getCharacterLocation()
    func interactorDidFetchLocation(with result: Result<Location, Error>)
}

class DetailPresenter: DetailPresenterProtocol {
    var router: DetailRouterProtocol?
    var view: DetailViewProtocol?
    
    var interactor: DetailInteractorProtocol?
    
    var location: Location?
    var character: Character?

    func interactorDidFetchLocation(with result: Result<Location, Error>) {
        switch result {
        case .success(let location):
            self.location = location
            view?.update()
        case .failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
    
    func getCharacterLocation() {
        guard let url = character?.location.url else { return }
        interactor?.getCharacterLocation(from: url)
    }
}

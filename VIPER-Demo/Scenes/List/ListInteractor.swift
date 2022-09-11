//
//  ListInteractor.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import Foundation

protocol ListInteractorProtocol {
    var presenter: ListPresenterProtocol? { get set }
    
    func getCharacters()
}

class ListInteractor: ListInteractorProtocol {
    var presenter: ListPresenterProtocol?
    var service: CharactersService
    
    init() {
        service = CharactersService()
    }
        
    func getCharacters() {
        service.getCharacters(completion: { [weak self] characters in
            self?.presenter?.interactorDidFetchCharacters(with: .success(characters))
        }, failure: { [weak self] error in
            self?.presenter?.interactorDidFetchCharacters(with: .failure(error))
        })
    }
}

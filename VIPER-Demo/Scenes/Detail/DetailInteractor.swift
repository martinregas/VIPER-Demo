//
//  DetailInteractor.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 09/09/2022.
//

import Foundation

protocol DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol? { get set }
    
    func getCharacterLocation(from url: String)
}

class DetailInteractor: DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol?
    var service: LocationsService
    
    init() {
        service = LocationsService()
    }
        
    func getCharacterLocation(from url: String) {
        if url.isEmpty {
            self.presenter?.interactorDidFetchLocation(with: .failure(FetchError.failed))
        }
        
        service.getLocation(url: url, completion: { [weak self] location in
            self?.presenter?.interactorDidFetchLocation(with: .success(location))
        }, failure: { [weak self] error in
            self?.presenter?.interactorDidFetchLocation(with: .failure(error))
        })
    }
}

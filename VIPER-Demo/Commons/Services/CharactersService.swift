//
//  CharactersService.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import Foundation

class CharactersService {
    private var nextPage = "https://rickandmortyapi.com/api/character"
    
    private var networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getCharacters(completion: @escaping([Character]) -> (), failure: @escaping(Error) -> ()) {
        networkManager.request(url: nextPage) { (response: CharactersResponse) in
            self.nextPage = response.info.next
            completion(response.results)
        } failure: { error in
            failure(error)
        }
    }
}

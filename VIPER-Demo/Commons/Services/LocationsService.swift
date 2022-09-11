//
//  LocationsService.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 09/09/2022.
//

import UIKit

class LocationsService {
    private var networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getLocation(url: String, completion: @escaping(Location) -> (), failure: @escaping(Error) -> ()) {
        networkManager.request(url: url) { (response: Location) in
            completion(response)
        } failure: { error in
            failure(error)
        }
    }
}

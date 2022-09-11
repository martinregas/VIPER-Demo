//
//  NetworkManager.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 07/09/2022.
//

import Foundation

class NetworkManager {
    func request<T:Decodable>(url:String, completion: @escaping(T) -> (), failure: @escaping(Error) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)

                DispatchQueue.main.async {
                    completion(response)
                }
            } catch(let error) {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
            
        }.resume()
    }
}

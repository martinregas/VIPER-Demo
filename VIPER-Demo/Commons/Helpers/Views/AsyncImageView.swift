//
//  AsyncImageView.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 11/09/2022.
//

import UIKit

fileprivate let imageCache = URLCache()

class AsyncImageView: UIImageView {
    private weak var task: URLSessionTask?
    
    func load(url: String, placeholder: UIImage?) {
        guard let url = URL(string: url) else {
            self.image = placeholder
            return
        }
        
        let request = URLRequest(url: url)
        
        if let data = imageCache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    imageCache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            })
            task?.resume()
        }
    }
    
    func cancel() {
        task?.cancel()
    }
}

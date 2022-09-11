import UIKit

fileprivate let imageCache = URLCache()

extension UIImageView {
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
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    imageCache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}

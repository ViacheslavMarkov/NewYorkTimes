//
//  UIImageView+Extension.swift
//  NYUI
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import UIKit

public class ImageCacher {
    
    public static let shared = ImageCacher()
    
    var cachableElements = NSCache<AnyObject, AnyObject>()

    public func saveImage(image: UIImage, key: String) {
        ImageCacher.shared.cachableElements.setObject(image, forKey: key as AnyObject)
    }
    
    public func loadImage(key: String) -> UIImage? {
        return ImageCacher.shared.cachableElements.object(forKey:key as AnyObject) as? UIImage
    }
    
    public func removeFromCache(key: String) {
        ImageCacher.shared.cachableElements.removeObject(forKey: key as AnyObject)
    }
}

public extension UIImageView {
    func imageFromServerURLWithCompletion(urlString: String, completion: ((_ image: UIImage?) -> ())? = nil) {
        image = nil
        guard let url = URL(string: urlString) else { return }
        
        if let image = ImageCacher.shared.loadImage(key: urlString) {
            self.image = image
            completion?(image)
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                DispatchQueue.main.async() {
                    completion?(nil)
                }
                    return
            }
            DispatchQueue.main.async() {
                    self?.image = image
                    ImageCacher.shared.saveImage(image: image, key: urlString)
                completion?(image)
                }
        }.resume()
    }
}

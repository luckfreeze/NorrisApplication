//
//  ImageCache.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 21/10/21.
//

import UIKit

class ImageCache {
    
    static let shared: ImageCache = {
        let instance = ImageCache()
        return instance
    }()
    
    private init() {}
    
    let cache = NSCache<NSString, NSData>()

    func getImage(using resourceUrl: URL, completion: @escaping (UIImage?) -> ()) {
        let imageId = resourceUrl.path as NSString
        if let savedImage = cache.object(forKey: imageId) {
            completion(UIImage(data: savedImage as Data) )
        } else {
            
            let imageData = NSData(contentsOf: resourceUrl) ?? NSData()
            cache.setObject(imageData, forKey: imageId)
            
            let image = UIImage(data: imageData as Data)
            completion(image)
        }
    }
}

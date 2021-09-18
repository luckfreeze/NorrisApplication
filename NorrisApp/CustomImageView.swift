//
//  CustomImageView.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        indicator.hidesWhenStopped = true
        indicator.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        indicator.isUserInteractionEnabled = false
        indicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        return indicator
    }()
    
    var imageUrlString: String?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(activityIndicator)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    /// Load image from cache or url string and cache it if necessary.
    /// - Parameters:
    ///   - urlString: url as String
    ///   - completion: completion handler
    func loadAndCacheImage(from urlString: String, completion: (() -> Void)? = nil) {
        if let url = URL(string: urlString) {
            loadAndCacheImage(from: url, completion: completion)
        }
    }
    
    /// Load image from cache or URL and cache it if necessary.
    /// - Parameters:
    ///   - url: URL
    ///   - completion: completion handler
    func loadAndCacheImage(from url: URL, completion: (() -> Void)? = nil) {
        let urlString = url.absoluteString
        imageUrlString = urlString
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            completion?()
            return
        }
        
        let networkLayer = NetworkURLSession()
        
        activityIndicator.startAnimating()
        networkLayer.get(url, headers: nil, completion: { [weak self] result in
            switch result {
                case .success(let data):
                    self?.activityIndicator.stopAnimating()
                    if let imageToCache = UIImage(data: data) {
                        if self?.imageUrlString == urlString {
                            self?.image = imageToCache
                        }
                        imageCache.setObject(imageToCache, forKey: urlString as NSString)
                        completion?()
                    }
                
                case .failure: self?.activityIndicator.stopAnimating()
            }
        })
    }
    
}

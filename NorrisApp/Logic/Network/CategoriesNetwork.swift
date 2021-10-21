//
//  CategoriesNetwork.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import Foundation

typealias CategoriesNetworkCompletion = (Data? , URLResponse?, Error?) -> Void

protocol CategoriesNetworkType {
    func getRandom(completion: @escaping CategoriesNetworkCompletion)
    func getCategories(completion: @escaping CategoriesNetworkCompletion)
    func getCategory(_ detail: String, completion: @escaping CategoriesNetworkCompletion)
}

class CategoriesNetwork: CategoriesNetworkType {
    
    var session: URLSession?
    
    init(sessionConfig: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: sessionConfig)
    }
    
    func getRandom(completion: @escaping CategoriesNetworkCompletion) {
        let randomURL = URL(string: CategoriesUrl.random.getUrl)!
        session?.dataTask(with: randomURL) { (data, urlResponse, error) in
            completion(data, urlResponse, error)
        }.resume()
    }
    
    func getCategories(completion: @escaping CategoriesNetworkCompletion) {
        let categoriesURL = URL(string: CategoriesUrl.categories.getUrl)!
        session?.dataTask(with: categoriesURL) { (data, urlResponse, error) in
            completion(data, urlResponse, error)
        }.resume()
    }
    
    func getCategory(_ detail: String, completion: @escaping CategoriesNetworkCompletion) {
        let categoryURL = URL(string: CategoriesUrl.categoryDetail(category: detail).getUrl)!
        session?.dataTask(with: categoryURL) { (data, urlResponse, error) in
            completion(data, urlResponse, error)
        }.resume()
    }
}

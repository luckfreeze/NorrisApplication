//
//  NorrisNetwork.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import Foundation

typealias NorrisNetworkCompletion = (Data? , URLResponse?, Error?) -> Void

protocol NorrisNetworkType {
    func getRandom(completion: @escaping NorrisNetworkCompletion)
    func getCategories(completion: @escaping NorrisNetworkCompletion)
    func getCategory(_ detail: String, completion: @escaping NorrisNetworkCompletion)
}

class NorrisNetwork: NorrisNetworkType {
    
    let sessionConfig = URLSessionConfiguration.default
    lazy var session = URLSession(configuration: sessionConfig)
    
    init() {}
    
    func getRandom(completion: @escaping NorrisNetworkCompletion) {
        let randomURL = URL(string: NorrisUrl.random.getUrl)!
        session.dataTask(with: randomURL) { (data, urlResponse, error) in
            completion(data, urlResponse, error)
        }.resume()
    }
    
    func getCategories(completion: @escaping NorrisNetworkCompletion) {
        let categoriesURL = URL(string: NorrisUrl.categories.getUrl)!
        session.dataTask(with: categoriesURL) { (data, urlResponse, error) in
            completion(data, urlResponse, error)
        }.resume()
    }
    
    func getCategory(_ detail: String, completion: @escaping NorrisNetworkCompletion) {
        let categoryURL = URL(string: NorrisUrl.categoryDetail(category: detail).getUrl)!
        session.dataTask(with: categoryURL) { (data, urlResponse, error) in
            completion(data, urlResponse, error)
        }.resume()
    }
}



/*
 

 
 Servidor tem Comandos

 
 Deletar Dados
 DELETE

 Consultar Dados
 GET
 
 
 
 StatusCode
 
 200 ok
 401 Não autorizado
 501 Problema no servidor
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */

//
//  NorrisBusiness.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import Foundation

class NorrisBusiness {
    
    var network: NorrisNetworkType?
    
    init(network: NorrisNetworkType = NorrisNetwork()) {
        self.network = network
    }
    
    
    
    
    
    
    
    
    
    func getCategories(completion: @escaping (_ categories: Categories?, _ statusCode: Int) -> Void) {
        network?.getCategories(completion: { (data, urlResponse, error) in
            guard let response = urlResponse as? HTTPURLResponse,
                  let norrisData = data else { return }
            
            if error != nil {
                completion(nil, response.statusCode)
            } else {
                
                let dataDecoded = try? JSONDecoder().decode([String].self, from: norrisData)
                let categories = Categories.init(dataDecoded)
                completion(categories, response.statusCode)
            }
        })
    }
    
    
    
    
    
    
    
    
    
    
    func getCategory(_ detail: String, completion: @escaping (_ categories: Category?, _ statusCode: Int) -> Void) {
        
        network?.getCategory(detail, completion: { (data, urlResponse, error) in
            guard let response = urlResponse as? HTTPURLResponse,
                  let norrisData = data else { return }
            
            if error != nil {
                completion(nil, response.statusCode)
            } else {
                
                let dataDecoded = try? JSONDecoder().decode(Category.self, from: norrisData)
                completion(dataDecoded, response.statusCode)
            }
        })
    }
}






/*
 
 
 ["animal","career","celebrity","dev","explicit","fashion","food","history","money","movie","music","political","religion","science","sport","travel"]
 
 
 
 
 */




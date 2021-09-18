//
//  NorrisUrl.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import Foundation

enum NorrisUrl {
    case random
    case categories
    case categoryDetail(category: String)
    
    var getUrl: String {
        switch self {
            case .random:
                return defaultURL + "random"
                
            case .categories:
                return defaultURL + "categories"
                
            case let .categoryDetail(category):
                return defaultURL + "random?category=\(category)"
        }
    }
    
    var defaultURL: String {
      return "https://api.chucknorris.io/jokes/"
    }
}
















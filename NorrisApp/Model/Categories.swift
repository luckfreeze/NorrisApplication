//
//  Categories.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import Foundation

class Categories: Codable {
    let categories: [String]?
    
    init(_ categories: [String]?) {
        self.categories = categories
    }
}

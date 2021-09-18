//
//  Category.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import Foundation

class Category: Codable {
    let categories: [String]?
    let createdAt: String?
    let iconUrl: String?
    let id: String?
    let updatedAt: String?
    let url: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        
        case categories
        case createdAt = "created_at"
        case iconUrl = "icon_url"
        case id
        case updatedAt = "updated_at"
        case url
        case description = "value"
    }
}

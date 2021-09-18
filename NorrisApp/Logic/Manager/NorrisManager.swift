//
//  NorrisManager.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import Foundation

enum NorrisSuccessType {
    case successOnCategory(Category)
    case successOnCategories(Categories)
    case successOnRandom
}

enum NorrisErrorType {
    case error
    case errorOnDecoded
}

protocol NorrisManagerDelegate: class {
    func handleSuccess(type: NorrisSuccessType)
    func handleError(type: NorrisErrorType)
}

class NorrisManager {
    
    private weak var delegate: NorrisManagerDelegate?
    private var business: NorrisBusiness?
    
    public init(delegate: NorrisManagerDelegate, business: NorrisBusiness? = NorrisBusiness()) {
        self.delegate = delegate
        self.business = business
    }
    
    func getCategories() {
        business?.getCategories(completion: { (categories, statusCode) in
            
            switch statusCode {
                case 200:
                    
                    guard let safeCategories = categories else {
                        self.delegate?.handleError(type: .errorOnDecoded)
                        return
                    }

                    self.delegate?.handleSuccess(type: .successOnCategories(safeCategories))

                    break
                default:
                    self.delegate?.handleError(type: .error)
                    break
            }
        })
    }
    
    func getCategory(_ detail: String) {
        business?.getCategory(detail, completion: { (category, statusCode) in
            switch statusCode {
                case 200:
                    
                    guard let safeCategory = category else {
                        self.delegate?.handleError(type: .errorOnDecoded)
                        return
                    }
                    
                    self.delegate?.handleSuccess(type: .successOnCategory(safeCategory))
                    break
                    
                default:
                    break
            }
        })
    }
}

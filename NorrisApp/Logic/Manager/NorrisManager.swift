//
//  NorrisManager.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import Foundation

enum NorrisSuccessType {
    case successOnCategory(SingleCategory)
    case successOnCategories([String]?)
    case successOnRandom
    case empty
}

enum NorrisErrorType {
    case error
}

protocol NorrisManagerDelegate: AnyObject {
    func handleSuccess(type: NorrisSuccessType)
    func handleError(type: NorrisErrorType)
}

protocol NorrisManagerType {
    func getCategories()
    func getCategory(_ detail: String)
}

class NorrisManager: NorrisManagerType {
    
    weak var delegate: NorrisManagerDelegate?
    var business: NorrisBusinessType?
    
    public init(delegate: NorrisManagerDelegate, business: NorrisBusinessType? = NorrisBusiness()) {
        self.delegate = delegate
        self.business = business
    }
    
    func getCategories() {
        business?.getCategories(completion: { (categories, statusCode) in
            
            switch statusCode {
                case 200:
                    
                    guard let allCategories = categories?.categories else {
                        self.delegate?.handleSuccess(type: .empty)
                        return
                    }
                    
                    self.delegate?.handleSuccess(type: .successOnCategories(allCategories))
                    
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
                
                guard let safeCategory = category, let _ = safeCategory.id else {
                    self.delegate?.handleSuccess(type: .empty)
                    return
                }
                
                self.delegate?.handleSuccess(type: .successOnCategory(safeCategory))
                break
                
            default:
                self.delegate?.handleError(type: .error)
                break
            }
        })
    }
}

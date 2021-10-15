//
//  SupportClasses.swift
//  NorrisAppTests
//
//  Created by Lucas Moraes on 20/09/21.
//

import Foundation

enum ResponseType {
    case success
    case empty
    case error
    case none
}

class NorrisURLProtocolMock: URLProtocol {
    
    static var responseType: ResponseType = .none
    static var stubResponseData: Data?
    static var error: Error?
    
    static func sessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [NorrisURLProtocolMock.self]
        return sessionConfiguration
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        switch NorrisURLProtocolMock.responseType {
        case .success:
            
            let response = HTTPURLResponse(url: MockUrl.defaultURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            self.client?.urlProtocol(self, didLoad: NorrisURLProtocolMock.stubResponseData ?? Data())
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
        case .empty:
            let response = HTTPURLResponse(url: MockUrl.defaultURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            self.client?.urlProtocol(self, didLoad: NorrisURLProtocolMock.stubResponseData ?? Data())
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
        case .error :
            
            let response = HTTPURLResponse(url: MockUrl.defaultURL, statusCode: 400, httpVersion: nil, headerFields: nil)!
            self.client?.urlProtocol(self, didLoad: Data())
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
        default:
            break
            
        }
        self.client?.urlProtocolDidFinishLoading(self)
        
    }
    
    override func stopLoading() { }
}

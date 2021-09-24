//
//  ResultsMock.swift
//  NorrisAppTests
//
//  Created by Lucas Moraes on 20/09/21.
//

import Foundation

class ResultMock {
    
    let categoriesDataSuccess = """
        ["animal","career","celebrity","dev","explicit","fashion","food","history","money", "movie", "music", "political", "religion", "science", "sport", "travel"]
        """.data(using: .utf8)!
    
     let randomDataSuccess = """
        {"categories":[],"created_at":"2020-01-05 13:42:21.455187","icon_url":"https://assets.chucknorris.host/img/avatar/chuck-norris.png","id":"cQBdsKTxTl-O-8_Ufhsu5g","updated_at":"2020-01-05 13:42:21.455187","url":"https://api.chucknorris.io/jokes/cQBdsKTxTl-O-8_Ufhsu5g","value":"Chuck Norris washes his clothes with fabric hardener."}
        """.data(using: .utf8)!
    
    let categoryDataSuccess = """
          {
          "categories" : [ "food" ],
          "created_at" : "2020-01-05 13:42:19.576875",
          "id" : "-ojrkppmrqmwrn9e5huydq",
          "icon_url" : "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
          "value" : "Chuck Norris starts everyday with a protein shake made from Carnation Instant Breakfast, one dozen eggs, pure Colombian cocaine, and rattlesnake venom. He injects it directly into his neck with a syringe.",
          "updated_at" : "2020-01-05 13:42:19.576875",
          "url" : "https://api.chucknorris.io/jokes/-ojrkppmrqmwrn9e5huydq"
        }
        """.data(using: .utf8)!
    
    let emptyData = """
        {}
        """.data(using: .utf8)!
    
    let errorData = Data()
    
    let error = MockError.init()
    
    let defaultResponse = URLResponse(url: MockUrl.defaultURL, mimeType: nil, expectedContentLength: 10, textEncodingName: nil)
    
    let httpResponseSuccess = HTTPURLResponse(url: MockUrl.defaultURL, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
    
    let httpResponseError = HTTPURLResponse(url: MockUrl.defaultURL, statusCode: 400, httpVersion: "HTTP/1.1", headerFields: nil)
}

class MockError: Error {
    init() {}
}

class MockUrl {
    static let defaultURL = URL(string: "https://api.chucknorris.io")!
}

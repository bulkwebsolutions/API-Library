//
//  ApiWrapper.swift
//  API-Library
//
//  Created by Centra Tech on 11/10/17.
//  Copyright © 2017 API-Library. All rights reserved.
//

import Foundation

struct ApiWrapper {
    let items: [Serialization]
}

protocol ApiResource {
    associatedtype Model
    var methodPath: String { get }
    func makeModel(serialization: Serialization) -> Model
}


extension ApiResource {
    var url: URL {
        let baseUrl = "https://api.stackexchange.com/2.2"
        let site = "site=stackoverflow"
        let order = "order=desc"
        let sorting = "sort=votes"
        let tags = "tagged=ios"
        let url = baseUrl + methodPath + "?" + order + "&" + sorting + "&" + tags + "&" + site
        return URL(string: url)!
    }
    
    func makeModel(data: Data) -> [Model]? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
            return nil
        }
        guard let jsonSerialization = json as? Serialization else {
            return nil
        }
        let wrapper = ApiWrapper(serialization: jsonSerialization)
        return wrapper.items.map(makeModel(serialization:))
    }
    
 
}

struct QuestionsResource: ApiResource {
    let methodPath = "/questions"
    
    func makeModel(serialization: Serialization) -> Question {
        return Question(serialization: serialization)
    }
}



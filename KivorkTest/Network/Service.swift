//
//  Service.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

enum ServiceMethod: String {
    case get = "GET"
    // implement more when needed: post, put, delete, patch, etc.
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var method: ServiceMethod { get }
}

extension Service {
    
    var baseURL: String {
        return "https://partners.api.skyscanner.net"
    }
    
    var apiKey: String {
        return "prtl6749387986743898559646983194"
    }
}

extension Service {
    
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        guard var params = parameters as? [String: String] else {
            fatalError("parameters for GET http method must conform to [String: String]")
        }

        params["apiKey"] = self.apiKey
        urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return urlComponents?.url
    }
}

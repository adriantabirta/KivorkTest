//
//  PlacesService.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

enum PlacesService {
    case autocomplete(country: String, currency: String, locale: String, query: String)
    case countries(locale: String)
    case currencies
}

extension PlacesService: Service {
    
    var method: ServiceMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .autocomplete(let country, let currency, let locale, _):
            return "/apiservices/autosuggest/v1.0/\(country)/\(currency)/\(locale)"
            
        case .countries(let locale):
            return "/apiservices/reference/v1.0/countries/\(locale)"
            
        case .currencies:
            return "/apiservices/reference/v1.0/currencies"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .autocomplete(_, _, _, let query):
            return ["query": query]
            
        case .countries(_):
            return [:]
            
        case .currencies:
            return [:]
        }
    }
}

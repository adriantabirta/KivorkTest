//
//  QuotesService.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

enum QuotesService {
    case browse(originCountry: String, currency: String, locale: String, originPlace: String, destinationPlace: String, outboundPartialDate: String?)
}

extension QuotesService: Service {
    
    var method: ServiceMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .browse(let originCountry, let currency, let locale, let originPlace, let destinationPlace, let outboundPartialDate):
            let path = "/apiservices/browsequotes/v1.0/\(originCountry)/\(currency)/\(locale)/\(originPlace)/\(destinationPlace)"
            guard let date = outboundPartialDate, !date.isEmpty else { return "\(path)/anytime" }
            return "\(path)/\(date)"
        }
    }
    
    var parameters: [String : Any] {
        return [:]
    }
}

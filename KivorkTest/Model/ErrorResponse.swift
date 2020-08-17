//
//  ErrorResponse.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/17/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case noInternetConnection
    case toManyRequests
    case invalidInput(String)
}

extension ApiError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .noInternetConnection:
            return "no_internet_connection".localized
        case .toManyRequests:
            return "to_many_requests".localized
        case .invalidInput(let info):
            return info.localized
            
        }
    }
}

struct ErrorResponse: Codable {
    
    var ValidationErrors: [ErrorItem]
    
    struct ErrorItem: Codable {
        var ParameterName: String
        var ParameterValue: String
        var Message: String
    }
    
    

}

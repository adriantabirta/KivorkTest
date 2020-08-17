//
//  QoutesRespone.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

struct QoutesResponse: Codable {
    
    var Quotes: [Quoute]
    var Places: [Place]
    var Carriers: [Carrier]
    var Currencies: [Currency]
}

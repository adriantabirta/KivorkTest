//
//  Quote.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation


//{
//    "QuoteId": 1,
//    "MinPrice": 1757.0,
//    "Direct": false,
//    "OutboundLeg": {
//        "CarrierIds": [
//            1375
//        ],
//        "OriginId": 63446,
//        "DestinationId": 44759,
//        "DepartureDate": "2020-09-10T00:00:00"
//    },
//    "QuoteDateTime": "2020-08-12T16:30:00"
//}
struct Quoute: Codable {
    
    var QuoteId: Int
    var MinPrice: Double
    var Direct: Bool
    var OutboundLeg: OutboundLeg
    var QuoteDateTime: Date
}

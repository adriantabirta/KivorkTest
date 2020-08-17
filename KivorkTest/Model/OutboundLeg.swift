//
//  OutboundLeg.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

struct OutboundLeg: Codable {

    var CarrierIds: [Int]
    var OriginId: Int
    var DestinationId: Int
    var DepartureDate: Date
}


//
//  Location.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

//{
//    "PlaceId": "LOND-sky",
//    "PlaceName": "Londra",
//    "CountryId": "UK-sky",
//    "RegionId": "",
//    "CityId": "LOND-sky",
//    "CountryName": "Regatul Unit"
//},
struct Location: Codable {
    
    var PlaceId: String
    var PlaceName: String
    var CountryId: String
    var RegionId: String
    var CityId: String
    var CountryName: String
}

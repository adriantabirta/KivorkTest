//
//  Place.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

struct Place: Codable {

    var PlaceId: Int
    var IataCode: String?
    var Name: String
    var `Type`: String
    var SkyscannerCode: String
    var CityName: String?
    var CityId: String?
    var CountryName: String?
    
    //    {
    //              "PlaceId": 42413,
    //              "IataCode": "BCM",
    //              "Name": "Bacău",
    //              "Type": "Station",
    //              "SkyscannerCode": "BCM",
    //              "CityName": "Bacău",
    //              "CityId": "BACA",
    //              "CountryName": "România"
    //          }
        
}

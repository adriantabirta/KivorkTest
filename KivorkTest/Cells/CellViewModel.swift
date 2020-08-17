//
//  CellViewModel.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/17/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

struct CellViewModel {
    
    private var quoute: Quoute
    private var places: [Place]
    private var carriers: [Carrier]
    private var currencySymbol: String
    
    init(quote: Quoute, places: [Place], carriers: [Carrier], currencySymbol: String) {
        self.quoute = quote
        self.places = places
        self.carriers = carriers
        self.currencySymbol = currencySymbol
    }
}

// MARK: - Public

extension CellViewModel {
    
    var fromCountry: String {
         guard let index = places.firstIndex(where: { return $0.PlaceId == quoute.OutboundLeg.OriginId }) else { return "" }
         return "\(places[index].SkyscannerCode ) ( \(places[index].CityName ?? places[index].Name) )"
     }
    
    var fromCity: String {
        guard let index = places.firstIndex(where: { return $0.PlaceId == quoute.OutboundLeg.OriginId }) else { return "" }
        return places[index].CityName ?? places[index].Name
    }
    
    var toCountry: String {
        guard let index = places.firstIndex(where: { return $0.PlaceId == quoute.OutboundLeg.DestinationId }) else { return "" }
        return "\(places[index].SkyscannerCode ) ( \(places[index].CityName ?? places[index].Name) )"
    }
        
    var toCity: String {
        guard let index = places.firstIndex(where: { return $0.PlaceId == quoute.OutboundLeg.DestinationId }) else { return "" }
        return places[index].CityName ?? places[index].Name
    }
    
    var departureDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from:  quoute.OutboundLeg.DepartureDate)
    }
    
    var directFly: String {
        return quoute.Direct ? "direct_fly".localized : ""
    }
    
    var companyName: String {
        guard let id = quoute.OutboundLeg.CarrierIds.first,
            let index = carriers.firstIndex(where: { return $0.CarrierId == id }) else { return "" }
        return  carriers[index].Name
    }
    
    var price: String {
        return "\("price".localized): \(quoute.MinPrice) \(currencySymbol)"
    }
}

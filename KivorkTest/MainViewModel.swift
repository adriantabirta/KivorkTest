//
//  MainViewModel.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

class MainViewModel {
    
    private let quotesProvider: ServiceProvider<QuotesService>
    
    private var _onDataChange: () -> Void
    
    private var _onError: (Error) -> Void
    
    private var _onEmpty: () -> Void
    
    private var quoutes: [Quoute]
    
    private var places: [Place]
    
    private var carriers: [Carrier]
    
    private var currencies: [Currency]
    
    
    init(quotesProvider: ServiceProvider<QuotesService> = ServiceProvider<QuotesService>()) {
        self.quotesProvider = quotesProvider
        self.quoutes = []
        self.places = []
        self.carriers = []
        self.currencies = []
        self._onDataChange = { }
        self._onError = { _ in }
        self._onEmpty = {}
    }
}

// MARK: - Private

extension MainViewModel {
    
    private var currentCountry: String {
        return UserDefaults.standard.string(forKey: "country") ?? ""
    }
    
    private var currentCurrency: String {
        return UserDefaults.standard.string(forKey: "currency") ?? ""
    }
    
    private var locale: String {
        return Locale.current.description
    }
}

// MARK: - Public

extension MainViewModel {
    
    func searchQuotes(from: String, to: String, departureDate: String?) {
        
        self.quoutes = []
        quotesProvider.load(service: .browse(originCountry: self.currentCountry,
                                             currency: self.currentCurrency,
                                             locale: "ro-RO",
                                             originPlace: from,
                                             destinationPlace: to,
                                             outboundPartialDate: departureDate),
                            decodeType: QoutesResponse.self) { [weak self] result in
                                switch result {
                                case .success(let resp):
                                    self?.quoutes = resp.Quotes
                                    self?.places = resp.Places
                                    self?.carriers = resp.Carriers
                                    self?.currencies = resp.Currencies
                                    
                                    self?._onDataChange()
                                case .failure(let error):
                                    print(error.localizedDescription)
                                    self?._onError(error as Error)
                                case .empty:
                                    self?._onEmpty()
                                }
        }
    }
    
    var numberOfRows: Int {
        return quoutes.count
    }
    
    func dataForIndex(_ index: Int) -> (Quoute, [Place], [Carrier], String) {
        let quoute = quoutes[index]
        
        guard let originPlaceIndex = places.firstIndex(where: { $0.PlaceId == quoute.OutboundLeg.OriginId }),
            let destinationPlaceIndex = places.firstIndex(where: { $0.PlaceId == quoute.OutboundLeg.DestinationId }),
            let carrierIndex = carriers.firstIndex(where: { $0.CarrierId == quoute.OutboundLeg.CarrierIds.first }),
            let symbol = currencies.first?.Symbol else { return (quoute, [], [], "") }
        
        return (quoute, [places[originPlaceIndex], places[destinationPlaceIndex]], [carriers[carrierIndex]], symbol)
    }
    
    @discardableResult
    func onDataChange(_ onDataChange: @escaping () -> Void) -> Self {
        self._onDataChange = onDataChange
        return self
    }
    
    @discardableResult
    func onError(_ onError: @escaping (Error) -> Void) -> Self {
        self._onError = onError
        return self
    }
    
    @discardableResult
    func onEmpty(_ onEmpty: @escaping () -> Void) -> Self {
        self._onEmpty = onEmpty
        return self
    }
}

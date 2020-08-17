//
//  CurrencyPickerViewModel.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/17/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

class CurrencyPickerViewModel {
    
    private let placesProvider: ServiceProvider<PlacesService>
    
    private var _onUpdate: () -> Void
    
    private var data: [Currency] {
        didSet { _onUpdate() }
    }
    
    init(placesProvider: ServiceProvider<PlacesService> = ServiceProvider<PlacesService>()) {
        self.placesProvider = placesProvider
        self.data = []
        self._onUpdate = { }
        placesProvider.load(service: .currencies,
                            decodeType: CurrenciesResponse.self) { [weak self] (result) in
                                switch result {
                                case .success(let resp):
                                    self?.data = resp.Currencies
                                case .failure(let error):
                                    print(error.localizedDescription)
                                case .empty:
                                    print("No data")
                                }
        }
    }
}

// MARK: - Private

extension CurrencyPickerViewModel {
    
//    private var locale: String {
//        return Locale.current.description
//    }
}

// MARK: - Public

extension CurrencyPickerViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return data.count
    }
    
    func titleForRow(row: Int) -> String {
        return "\(data[row].Code)"
    }
    
    func save(_ row: Int) {
        UserDefaults.standard.set(titleForRow(row: row), forKey: "currency")
    }
    
    var savedCountry: String {
        return UserDefaults.standard.string(forKey: "currency") ?? ""
    }
    
    func onUpdate(completion: @escaping () -> Void) {
        self._onUpdate = completion
    }
}


//
//  CountryPickerViewModel.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

class CountryPickerViewModel {
    
    private let placesProvider: ServiceProvider<PlacesService>
    
    private var _onUpdate: () -> Void
    
    private var data: [Country] {
        didSet { _onUpdate() }
    }
    
    init(placesProvider: ServiceProvider<PlacesService> = ServiceProvider<PlacesService>()) {
        self.placesProvider = placesProvider
        self.data = []
        self._onUpdate = { }
        placesProvider.load(service: .countries(locale: "ro-RO"),
                            decodeType: CountriesResponse.self) { [weak self] (result) in
                                switch result {
                                case .success(let resp):
                                    self?.data = resp.Countries
                                case .failure(let error):
                                    print(error.localizedDescription)
                                case .empty:
                                    print("No data")
                                }
        }
    }
}

// MARK: - Private

extension CountryPickerViewModel {
    
//    private var locale: String {
//        return Locale.current.regionCode ?? ""
//    }
}

// MARK: - Public

extension CountryPickerViewModel {
    
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
        UserDefaults.standard.set(titleForRow(row: row), forKey: "country")
    }
    
    var savedCountry: String {
        return UserDefaults.standard.string(forKey: "country") ?? ""
    }
    
    func onUpdate(completion: @escaping () -> Void) {
        self._onUpdate = completion
    }
}

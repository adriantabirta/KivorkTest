//
//  TagsViewModel.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

class TagsViewModel {
    
    private var placesProvider: ServiceProvider<PlacesService>
    
    private var _onDataChange: () -> Void
    
    private var data: [Location] {
        didSet {
            _onDataChange()
        }
    }
    
    init(placesProvider: ServiceProvider<PlacesService> = ServiceProvider<PlacesService>()) {
        self.placesProvider = placesProvider
        self.data = []
        self._onDataChange = {}
    }
}

// MARK: - Private

extension TagsViewModel {
    
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

extension TagsViewModel {
    
    var numberOfRows: Int {
        return data.count
    }
    
    func dataAtIndex(index: IndexPath) -> Location {
        return data[index.row]
    }
    
    func onDataChange(closure: @escaping () -> Void) {
        self._onDataChange = closure
    }
    
    func update(_ text: String) {
        placesProvider.load(service: .autocomplete(country: currentCountry,
                                                   currency: currentCurrency,
                                                   locale: locale,
                                                   query: text),
                            decodeType: LocationsResponse.self) { [weak self] (result) in
                                switch result {
                                case .success(let resp):
                                    self?.data = resp.Places
                                case .failure(let error):
                                    print(error.localizedDescription)
                                case .empty:
                                    print("No data")
                                }
        }
    }
}

//
//  ProfileViewModel.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    var savedCountry: String {
        return UserDefaults.standard.string(forKey: "country") ?? ""
    }
    
    var savedCurrency: String {
        return UserDefaults.standard.string(forKey: "currency") ?? ""
    }
}

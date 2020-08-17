//
//  Profile.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var countryTitleLabel: UILabel!
    @IBOutlet weak var countryValueLabel: UILabel!
    @IBOutlet weak var hiddenCountryTextField: UITextField!
    
    @IBOutlet weak var currencyTitleLabel: UILabel!
    @IBOutlet weak var currencyValueLabel: UILabel!
    @IBOutlet weak var hiddenCurrencyTextField: UITextField!
    
    private lazy var viewModel: ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryTitleLabel.text = "country".localized
        currencyTitleLabel.text = "currency".localized
        
        configureCountry()
        
        configureCurrency()
    }
    
    @IBAction func tapCountryView(_ sender: Any) {
        hiddenCountryTextField.becomeFirstResponder()
    }
    
    @IBAction func tapCurrencyView(_ sender: Any) {
        hiddenCurrencyTextField.becomeFirstResponder()
    }
}

// MARK: - Private functions

extension ProfileController {
    
    private func configureCountry() {
        countryValueLabel.text = viewModel.savedCountry
       let pickerView = CountryPickerView().onChange({ [weak self] (text) in self?.countryValueLabel.text = text })
        hiddenCountryTextField.inputView = pickerView
        hiddenCountryTextField.inputAccessoryView = InputToolbar()
    }
    
    private func configureCurrency() {
        currencyValueLabel.text = viewModel.savedCurrency
        let pickerView = CurrencyPickerView().onChange({ [weak self] (text) in self?.currencyValueLabel.text = text })
        hiddenCurrencyTextField.inputView = pickerView
        hiddenCurrencyTextField.inputAccessoryView = InputToolbar()
    }
}

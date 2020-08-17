//
//  CurrencyPickerView.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/17/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import UIKit

class CurrencyPickerView: UIPickerView {
    
    private var viewModel: CurrencyPickerViewModel
    
    private var _onChange: (String) -> Void = { _ in }
    
    init(viewModel: CurrencyPickerViewModel = CurrencyPickerViewModel()) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        delegate = self
        dataSource = self
        self.viewModel.onUpdate { [weak self] in
            self?.reloadAllComponents()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.save(row)
        _onChange(viewModel.titleForRow(row: row))
    }
}

extension CurrencyPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.numberOfSections
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.titleForRow(row: row)
    }
}

extension CurrencyPickerView {
    
    func onChange(_ completion: @escaping (String) -> Void) -> Self {
        _onChange = completion
        return self
    }
}


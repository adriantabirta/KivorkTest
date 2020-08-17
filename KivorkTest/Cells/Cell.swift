//
//  Cell.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/13/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var originCodeLabel: UILabel!
    @IBOutlet weak var originCityCountryLabel: UILabel!

    @IBOutlet weak var destinationCodeLabel: UILabel!
    @IBOutlet weak var destinationCityCountryLabel: UILabel!
    
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var directFlyLabel: UILabel!

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    private var _viewModel: CellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Private

extension Cell {
        
    var viewModel: CellViewModel {
        set{
            self._viewModel = newValue
        }
        get { return self._viewModel }
    }
    
    func update() {
        originCodeLabel.text = _viewModel.fromCountry
        originCityCountryLabel.text = _viewModel.fromCity
        destinationCodeLabel.text = _viewModel.toCountry
        destinationCityCountryLabel.text = _viewModel.toCity
        departureDateLabel.text = _viewModel.departureDate
        directFlyLabel.text = _viewModel.directFly
        companyNameLabel.text = _viewModel.companyName
        priceLabel.text = _viewModel.price
    }
}

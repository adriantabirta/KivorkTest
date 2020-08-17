//
//  TagCell.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
    
    func configure(_ model: Location) {
        self.cityLabel.text = model.PlaceName
        self.countryLabel.text = model.CountryName
    }
}

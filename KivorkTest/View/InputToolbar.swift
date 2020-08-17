//
//  InputToolbar.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import UIKit

class InputToolbar: UIToolbar {
    
    var doneButton: UIBarButtonItem {
        return .init(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
    }
    
    lazy var toolBar = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        setItems([toolBar, doneButton], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    @objc private func dismissKeyboard() {
        UIApplication.shared.endEditing()
    }
}

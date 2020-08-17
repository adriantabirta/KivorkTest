//
//  Extensions.swift
//  KivorkTest
//
//  Created by Adrian Tabirta on 8/14/20.
//  Copyright © 2020 Adrian Tabirta. All rights reserved.
//

import UIKit

extension UIApplication {
    @objc func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIViewController {

    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if options.count == 0 {
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                 completion(0)
            })
            alertController.addAction(OKAction)
        } else {

            for (index, option) in options.enumerated() {
                 alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                    completion(index)
                }))
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}

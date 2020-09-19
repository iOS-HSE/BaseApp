//
//  Loader.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 18.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


protocol Loader {
    var indicator: UIActivityIndicatorView { get }
    func showIndicator()
    func hideIndicator()
    func createAlert(message: String)
}

extension Loader where Self: UIViewController {
    func showIndicator() {
        DispatchQueue.main.async {
            self.indicator.center = self.navigationController?.view.center ?? self.view.center
            self.indicator.startAnimating()
            self.indicator.superview?.bringSubviewToFront(self.indicator)
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
    
    func createAlert(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Oups", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(ok)
            self.present(alertController, animated: true , completion: nil)
        }
    }
}

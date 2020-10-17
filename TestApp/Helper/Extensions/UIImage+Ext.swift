//
//  UIImage+Ext.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 19.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


extension UIImageView {
    
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error loading image, description: \(error)")
                    self.image = UIImage(named: "hse")
                }
                guard let data = data else { return }
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
}

//
//  RequestExample.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 17.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation
import UIKit


class RequestExampleVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch()
    }
    
    func fetch() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing") else { return }
      
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data else { return }
            
            print(data)
        }
        
        task.resume()
    }
}

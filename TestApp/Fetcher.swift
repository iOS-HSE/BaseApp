//
//  Fetcher.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 19.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation



class Fetcher {
    
    static let shared = Fetcher()
    
    func request(_ endpoint: EndPoint,
                 completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path),
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = endpoint.headers
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                completion(Result.success(data!))
                
            }
        })
        
        dataTask.resume()
    }
    
}

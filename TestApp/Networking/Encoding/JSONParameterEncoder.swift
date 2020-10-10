//
//  JSONParameterEncoder.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 10.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation


public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let json = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            urlRequest.httpBody = json
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch  {
            throw NetworkError.encodingFailed
        }
    }
}

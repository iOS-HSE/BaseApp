//
//  ParameterEncoding.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 10.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation


public typealias Parameters = [String:Any]

public enum NetworkError: String, Error {
    case parametersAreNil = "Parameters are nil."
    case encodingFailed = "Parameters encoding failed."
    case missingURL = "URL is invalid."
}


public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    
    case url
    case json
    case urlAndJson
    
    public func encode(urlRequest: inout URLRequest, bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        do {
            switch self {
            case .url:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
            case .json:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            case .urlAndJson:
                guard let bodyParameters = bodyParameters, let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch  {
            throw error
        }
    }
}



//
//  ParameterEncoding.swift
//  myAccess
//
//  Created by ABA IT on 2/14/19.
//  Copyright © 2019 ozalsuleyman. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
    func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws
}

extension ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws {}
}

enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

let contentType = "Content-Type"

public class URLParameterEncoder: ParameterEncoder {
    public init() {}
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw NetworkError.missingURL
        }
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: contentType) == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: contentType)
        }
    }
}

public class JSONParameterEncoder: ParameterEncoder {
    public init() {}
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: contentType) == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: contentType)
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }

    public func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonAsData

            if urlRequest.value(forHTTPHeaderField: contentType) == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: contentType)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}


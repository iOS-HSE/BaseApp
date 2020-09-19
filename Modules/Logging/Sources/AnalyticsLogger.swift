//
//  Cache.swift
//  IBAMobileBank
//
//  Created by László Teveli on 2020. 04. 06..
//  Copyright © 2020. Shamkhal Guliyev. All rights reserved.
//

import Foundation

public protocol AnalyticsLoggerProtocol {
    func logEvent(name: String, parameters: [String: String])
}

public class ConsoleLogger: AnalyticsLoggerProtocol {
    public init() {}
    
    public func logEvent(name: String, parameters: [String : String]) {
        print("[Analytics]", name, parameters)
    }
}

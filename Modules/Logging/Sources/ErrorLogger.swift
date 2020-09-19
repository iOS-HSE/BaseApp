//
//  Cache.swift
//  IBAMobileBank
//
//  Created by László Teveli on 2020. 04. 06..
//  Copyright © 2020. Shamkhal Guliyev. All rights reserved.
//

import Foundation

public protocol ErrorLoggerProtocol {
    func logError(error: Error, info: String?)
}

public class ErrorLogger: ErrorLoggerProtocol {
    public init() {}
    
    public func logError(error: Error, info: String?) {
        // TODO: log to crashlytics
    }
}

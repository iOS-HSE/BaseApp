//
//  CustomLogDescriptionConvertible.swift
//  IBAMobileBankViewState
//
//  Created by International Bank of Azerbaijan on 9/7/20.
//  Copyright © International Bank of Azerbaijan. All rights reserved.
//

public protocol CustomLogDescriptionConvertible {
    var logDescription: String { get }
}

public extension CustomLogDescriptionConvertible {
    var logDescription: String {
        return String(describing: self)
    }
}

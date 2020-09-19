//
//  State.swift
//  IBAMobileBankViewState
//
//  Created by International Bank of Azerbaijan on 9/7/20.
//  Copyright © International Bank of Azerbaijan. All rights reserved.
//

public protocol StoreState: Equatable, CustomLogDescriptionConvertible {}
public protocol ViewState: StoreState {}

public extension Equatable where Self: StoreState {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return false
    }
}

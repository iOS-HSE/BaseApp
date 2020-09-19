//
//  CustomOperators.swift
//  IBAMobileBankViewState
//
//  Created by International Bank of Azerbaijan on 9/7/20.
//  Copyright © International Bank of Azerbaijan. All rights reserved.
//

public func += <T, U: StatefulView>(left: ViewModel<T>, right: U) where U.State == T {
    left.subscribe(from: right)
}

public func -= <T, U: StatefulView>(left: ViewModel<T>, right: U) where U.State == T {
    left.unsubscribe(from: right)
}

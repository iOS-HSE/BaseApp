//
//  StateSubscription.swift
//  IBAMobileBankViewState
//
//  Created by International Bank of Azerbaijan on 9/7/20.
//  Copyright © International Bank of Azerbaijan. All rights reserved.
//

public class StateSubscription<State> {
    private(set) var block: ((State) -> Void)?

    init(_ block: @escaping (State) -> Void) {
        self.block = block
    }

    func fire(_ state: State) {
        block?(state)
    }

    func stop() {
        block = nil
    }

    deinit {
        stop()
    }
}

//
//  StoreSubscriptionTests.swift
//  IBAMobileBankViewStateTests
//
//  Created by Khayal Suleyman on 9/7/20.
//  Copyright © 2020 Khayal Suleyman. All rights reserved.
//

import XCTest
@testable import IBAMobileBankViewState

class StoreSubscriptionTests: XCTestCase {
    
    func testStoreSubscriptionBlockIsInvokedCorrectly() {
        var blockFired = false
        let sut = StateSubscription { (_: StoreSubscriptionState) in
            blockFired = true
        }
        sut.fire(StoreSubscriptionState())
        XCTAssertTrue(blockFired)
    }

    func testStoreSubscriptionBlockIsNotInvokedAfterStopping() {
        var blockFired = false
        let sut = StateSubscription { (_: StoreSubscriptionState) in
            blockFired = true
        }
        sut.stop()
        sut.fire(StoreSubscriptionState())
        XCTAssertFalse(blockFired)
    }

    func testStoreSubscriptionIsStoppedAfterDeallocation() {
        var sut: StoreSubscriptionSpy? = StoreSubscriptionSpy { (_: StoreSubscriptionState) in }
        var blockFired = false
        sut!.stopCalledBlock = {
            blockFired = true
        }
        sut = nil
        XCTAssertTrue(blockFired)
    }
    
}

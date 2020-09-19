//
//  StatefulViewTests.swift
//  IBAMobileBankViewStateTests
//
//  Created by Khayal Suleyman on 9/7/20.
//  Copyright © 2020 Khayal Suleyman. All rights reserved.
//

import XCTest
@testable import IBAMobileBankViewState

class StatefulViewTests: XCTestCase {
    
    func testViewReceivesRenderMethod() {
        let viewSpy = ViewSpy()
        let statefulView = AnyStatefulView(viewSpy)
        statefulView.render(state: ViewSpyState(text: "Text"))
        XCTAssert(viewSpy.numberOfRenderCalls == 1)
    }
    
    func testRenderPolicyMethodCalledInView() {
        let viewSpy = ViewSpy()
        let statefulView = AnyStatefulView(viewSpy)
        _ = statefulView.renderPolicy
        XCTAssertTrue(viewSpy.renderPolicyCalled)
    }
    
    func testLogDescriptionMethodCalledInView() {
        let viewSpy = ViewSpy()
        let statefulView = AnyStatefulView(viewSpy)
        _ = statefulView.logDescription
        XCTAssertTrue(viewSpy.logDescriptionCalled)
    }
    
    func testViewControllerCannotBeRenderedWhenViewDeallocated() {
        var viewSpy: ViewSpy? = ViewSpy()
        weak var weakView = viewSpy
        let _ = AnyStatefulView(viewSpy!)
        viewSpy = nil
        XCTAssertNil(weakView)
    }
    
}


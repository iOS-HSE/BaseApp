//
//  StatefulView+Ext.swift
//  IBAMobileBankViewState
//
//  Created by Khayal Suleyman on 9/7/20.
//  Copyright © 2020 Khayal Suleyman. All rights reserved.
//

import UIKit

public extension StatefulView where Self: UIViewController {
    var renderPolicy: RenderPolicy {
        return isViewLoaded ? .possible : .notPossible(.viewNotReady)
    }

    var logDescription: String {
        return title ?? String(describing: type(of: self))
    }
}

public extension StatefulView where Self: UIView {
    var renderPolicy: RenderPolicy {
        return superview != nil ? .possible : .notPossible(.viewNotReady)
    }

    var logDescription: String {
        return String(describing: type(of: self))
    }
}

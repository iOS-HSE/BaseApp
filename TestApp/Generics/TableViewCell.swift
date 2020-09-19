//
//  TableViewCell.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 18.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


public protocol ReusableCell {
    static var reuseID: String { get }
}

public extension ReusableCell {
    static var reuseID: String {
        return String(describing: self)
    }
}

protocol ConfigureCell {
    associatedtype T
    var model: T! { get set }
    func configure(model: T!)
}

class TableViewCell<T>: UITableViewCell, ReusableCell, ConfigureCell {
    var model: T! {
        didSet {
            configure(model: model)
        }
    }
    
    func configure(model: T! ) {}
}

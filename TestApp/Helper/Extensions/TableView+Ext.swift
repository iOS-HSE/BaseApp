//
//  TableView+Ext.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 18.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit

public extension UITableView {
    final func register<T: UITableViewCell>(cellType: T.Type) where T: ReusableCell {
        self.register(cellType.self, forCellReuseIdentifier: cellType.reuseID)
    }
}

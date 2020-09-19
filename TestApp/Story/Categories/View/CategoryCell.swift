//
//  CategoryCell.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 19.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


class CategoryCell: TableViewCell<Category> {
    
    override func configure(model: Category!) {
        textLabel?.text = model.name
    }
    
}

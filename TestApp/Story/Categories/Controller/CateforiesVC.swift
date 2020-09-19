//
//  CateforiesVC.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 19.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit
import DependencyInjection

class CategoriesVC: GenericTableVC<CategoryCell, Category> {
   
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

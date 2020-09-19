//
//  NewListCell.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 19.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


struct NewListCellVM {
    var name: String
    var image: String
}

class NewListCell: TableViewCell<NewListCellVM> {
    
    override func configure(model: NewListCellVM!) {
        textLabel?.text = model.name
        imageView?.image = UIImage(named: model.image)
    }
    
}

//
//  NewMoviesCell.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 10.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


class NewMoviesCell: TableViewCell<Movie> {
    
    override func configure(model: Movie!) {
        self.textLabel?.text = model.title
    }
    
}

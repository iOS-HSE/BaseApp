//
//  NewMoviesVC.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 10.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


class NewMoviesVC: GenericTableVC<NewMoviesCell, Movie> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        view.backgroundColor = UIColor.Palette.backgroundGray
    }
    
    func fetch() {
        NetworkManager.shared.getNewMovies(page: 0) { movies, _ in
            self.dataSource = TableDataSource(models: movies ?? [], reuseID: "\(NewMoviesCell.self)")
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
}

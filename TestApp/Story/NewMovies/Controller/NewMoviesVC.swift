//
//  NewMoviesVC.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 10.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


class NewMoviesVC: GenericTableVC<NewMoviesCell, NewMoviesCellViewModel> {
    
    private let presenter = NewMoviesPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        view.backgroundColor = UIColor.Palette.backgroundGray
    }
    
    func fetch() {
        showIndicator()
        NetworkManager.shared.getNewMovies(page: 1) { movies, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.createAlert(message: error ?? "")
                }
                self.hideIndicator()
                let viewModel = self.presenter.viewModel(with: movies ?? [])
                self.dataSource = TableDataSource(models: viewModel, reuseID: "\(NewMoviesCell.self)")
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData() 
            }
        }
    }
    
}

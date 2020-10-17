//
//  NewMoviesPresenter.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 17.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation

protocol NewMoviesPresenterProtocol {
    func viewModel(with models: [Movie]) -> [NewMoviesCellViewModel]
}

class NewMoviesPresenter: NewMoviesPresenterProtocol {
    
    init() {}
    
    func viewModel(with models: [Movie]) -> [NewMoviesCellViewModel] {

        return models.map(NewMoviesCellViewModel.init)
    }

}

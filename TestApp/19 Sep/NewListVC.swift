//
//  NewListVC.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 19.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


class NewListVC: GenericTableVC<NewListCell, NewListCellVM> {
    
    let models = [NewListCellVM(name: "John", image: "hse"),
                  NewListCellVM(name: "Smith", image: "hse"),
                  NewListCellVM(name: "Watson", image: "hse"),
                  NewListCellVM(name: "Holmes", image: "hse")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Palette.backgroundGray
        dataSource = TableDataSource(models: models, reuseID: NewListCell.reuseID)
        tableView.dataSource = dataSource
    }
 
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Список"
    }
    
}

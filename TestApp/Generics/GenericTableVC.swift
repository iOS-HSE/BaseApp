//
//  GenericTableVC.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 18.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


class GenericTableVC<Cell: TableViewCell<Model>, Model>: UITableViewController, Loader {
    
    var indicator = UIActivityIndicatorView(style: .gray)
    
    typealias DataSource = TableDataSource<Model>
    
    var dataSource: DataSource? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: Cell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
        hideKeyboard()
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
}

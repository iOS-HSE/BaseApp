//
//  TableDataSource.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 18.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


class TableDataSource<Model>: NSObject, UITableViewDataSource {
    
    var models: [Model]
    
    private let reuseID: String
    
    typealias Completion = (TableViewCell<Model>) -> ()
    
    var completion: Completion = { _  in }
    
    init(models: [Model], reuseID: String) {
        self.models = models
        self.reuseID = reuseID
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? TableViewCell<Model> {
            cell.model = models[indexPath.row]
            completion(cell)
            return cell
        }
        return UITableViewCell()
    }
}

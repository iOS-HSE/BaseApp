//
//  MainVC.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 12.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


class MainVC: UITableViewController {
    
    var login: String
    var pass: String
    
    let loginLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = UIColor.Palette.backgroundGray
        lbl.textColor = UIColor.Palette.lightBlack
        return lbl
    }()
    
    let passLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.Palette.backgroundGray
        lbl.textColor = UIColor.Palette.lightBlack
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    required init(login: String, pass: String) {
        self.login = login
        self.pass = pass
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Palette.backgroundWhite
        setupUI()
        loginLabel.text = login
        passLabel.text = pass
    }
    
    func setupUI() {
        view.addSubview(loginLabel)
        view.addSubview(passLabel)
        
        NSLayoutConstraint.activate([
            loginLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            loginLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            loginLabel.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: -16),
            
            passLabel.leftAnchor.constraint(equalTo: loginLabel.leftAnchor),
            passLabel.rightAnchor.constraint(equalTo: loginLabel.rightAnchor),
            passLabel.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: 16)
        ])
    }
}

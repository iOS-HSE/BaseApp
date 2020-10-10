//
//  AutorizeVC.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 12.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit

class AutorizeVC: UIViewController {
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "hse")
        return imgView
    }()
    
    let loginTextField: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .roundedRect
        txt.placeholder = "Введите логин"
        return txt
    }()
    
    let passTextField: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .roundedRect
        txt.placeholder = "Введите пароль"
        txt.isSecureTextEntry = true
        return txt
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Войти", for: .normal)
        btn.backgroundColor = UIColor.Palette.blue
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(enterMainScreen), for: .touchUpInside)
        return btn
    }()

    let registerButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Регистрация", for: .normal)
        btn.backgroundColor = UIColor.Palette.backgroundGray
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    func setupUI() {
        view.addSubview(imageView)
        view.addSubview(loginTextField)
        view.addSubview(passTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -32),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            loginTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            loginTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            passTextField.leftAnchor.constraint(equalTo: loginTextField.leftAnchor),
            passTextField.rightAnchor.constraint(equalTo: loginTextField.rightAnchor),
            passTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            passTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 32),
            
            loginButton.leftAnchor.constraint(equalTo: loginTextField.leftAnchor),
            loginButton.rightAnchor.constraint(equalTo: loginTextField.rightAnchor),
            loginButton.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            loginButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 32),
            
            registerButton.leftAnchor.constraint(equalTo: loginTextField.leftAnchor),
            registerButton.rightAnchor.constraint(equalTo: loginTextField.rightAnchor),
            registerButton.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 32),
        ])
    }
    
    @objc func enterMainScreen() {
        //guard let login = loginTextField.text, let pass = passTextField.text else { return } 
//        navigationController?.pushViewController(MainVC(login: login, pass: pass), animated: true)
        navigationController?.pushViewController(NewListVC(), animated: true)
    }
}


extension AutorizeVC: UITextFieldDelegate {
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return true
//    }
    
}

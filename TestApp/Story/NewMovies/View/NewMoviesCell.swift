//
//  NewMoviesCell.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 10.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit


struct NewMoviesCellViewModel {
    let title: String
    let description: String
    let imageURL: String
    let release: String
    
    init(model: Movie) {
        self.title = model.title
        self.description = model.overview
        self.imageURL = MovieAPI.url + model.posterPath
        self.release = model.releaseDate
    }
}


class NewMoviesCell: TableViewCell<NewMoviesCellViewModel> {
    
    private let logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .red
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func configure(model: NewMoviesCellViewModel!) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        logoImageView.load(url: "https://image.shutterstock.com/image-vector/baby-pacifier-dummy-soother-teether-600w-680747476.jpg")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.layer.cornerRadius = logoImageView.bounds.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(logoImageView)
        addSubview(releaseDateLabel)
        addSubview(descriptionLabel)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            logoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            logoImageView.heightAnchor.constraint(equalToConstant: 64),
            logoImageView.widthAnchor.constraint(equalToConstant: 64),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            titleLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8),
            
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 8),
            
            
        ])
    }
}

//
//  MovieModel.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 10.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation


struct MovieAPIResponse: Codable {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Codable {
    let id: Int
    let posterPath: String
    let backdrop: String
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
    }
}

//
//- id : 528085
//- posterPath : "/7D430eqZj8y3oVkLFfsWXGRcpEG.jpg"
//- backdrop : "/5UkzNSOK561c2QRy2Zr4AkADzLT.jpg"
//- title : "2067"
//- releaseDate : "2020-10-01"
//- rating : 5.7
//- overview : "A lowly utility worker is called to the future by a mysterious radio signal, he must leave his dying wife to embark on a journey that will force him to face his deepest fears in an attempt to change the fabric of reality and save humankind from its greatest environmental crisis yet."
//

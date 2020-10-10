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

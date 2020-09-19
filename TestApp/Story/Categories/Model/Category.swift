//
//  Category.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 19.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation

public struct Categories: Codable {
    var categories: [Category]?
    
    enum CodingKeys: String, CodingKey {
        case categories = "drinks"
    }
}

public struct Category: Codable {
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}

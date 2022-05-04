//
//  Dish.swift
//  Yummie
//
//  Created by Наталья Шарапова on 27.04.2022.
//

import Foundation

struct Dish: Codable {
    
    let id, name, description, image: String
    let calories: Double
    
    var formattedCalories: String {
        return String(format: "%.2f calories", calories)
    }
    
}

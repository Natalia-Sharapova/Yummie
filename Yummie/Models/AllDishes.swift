//
//  AllDishes.swift
//  Yummie
//
//  Created by Наталья Шарапова on 29.04.2022.
//

import Foundation

struct AllDishes: Codable {
  
    let data: Dishes
}
    
struct Dishes: Codable {
        
    let categories: [DishCategory]
    let populars: [Dish]
    let specials: [Dish]
}

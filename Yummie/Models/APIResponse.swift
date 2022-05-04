//
//  APIResponse.swift
//  Yummie
//
//  Created by Наталья Шарапова on 03.05.2022.
//

import Foundation

struct ApiResponseSubmitOrder: Decodable {
    
    let status: Int
    let message: String
    let data: Order?
    let error: String?
}

struct ApiResponseGetCategoryDishes: Codable {
    
    let status: Int?
    let message: String?
    let data: [Dish]?
    let error: String?
    
}

struct ApiResponseGetOrders: Codable {
    
    let status: Int?
    let message: String?
    let data: [Order]?
    let error: String?
    
}

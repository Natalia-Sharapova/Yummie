//
//  AppError.swift
//  Yummie
//
//  Created by Наталья Шарапова on 04.05.2022.
//

import Foundation

enum AppError: LocalizedError {
    
    case errorDecoding
    case unknownError
    case invalideUrl
    case serverError(String)
    
    var errorDescription: String? {
        
        switch self {
        
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return  "I have no idea what go on"
        case .invalideUrl:
            return "Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}

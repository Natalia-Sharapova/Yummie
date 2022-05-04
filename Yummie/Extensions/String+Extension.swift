//
//  String+Extension.swift
//  Yummie
//
//  Created by Наталья Шарапова on 27.04.2022.
//

import Foundation

extension String {
    
    var asURL: URL? {
        return URL(string: self)
    }
}

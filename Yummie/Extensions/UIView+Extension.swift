//
//  UIView+Extension.swift
//  Yummie
//
//  Created by Наталья Шарапова on 23.04.2022.
//

import UIKit

extension UIView {
    
    // The ability to change the radius from 
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            return cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}

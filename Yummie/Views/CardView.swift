//
//  CardView.swift
//  Yummie
//
//  Created by Наталья Шарапова on 27.04.2022.
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 10
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
    }
}

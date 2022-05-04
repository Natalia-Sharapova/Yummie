//
//  PopularCollectionViewCell.swift
//  Yummie
//
//  Created by Наталья Шарапова on 27.04.2022.
//

import UIKit
import Kingfisher

class PopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    static let identifier = "PopularCollectionViewCell"
    
    // MARK: - Methods
    
    func setup(dish: Dish) {
        
        nameLabel.text = dish.name
        dishImage.kf.setImage(with: dish.image.asURL)
        caloriesLabel.text = dish.formattedCalories
        descriptionLabel.text = dish.description
    }
}

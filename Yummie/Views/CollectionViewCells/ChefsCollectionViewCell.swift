//
//  ChefsCollectionViewCell.swift
//  Yummie
//
//  Created by Наталья Шарапова on 27.04.2022.
//

import UIKit

class ChefsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageChefsDish: UIImageView!
    @IBOutlet weak var nameChefsDishLabel: UILabel!
    @IBOutlet weak var descriptionChefDishLabel: UILabel!
    @IBOutlet weak var caloriesChefsDishLabel: UILabel!
    
    // MARK: - Properties
    
    static let identifier = "ChefsCollectionViewCell"
    
    // MARK: - Methods
    
    func setup(dish: Dish) {
        
        imageChefsDish.kf.setImage(with: dish.image.asURL)
        nameChefsDishLabel.text = dish.name
        descriptionChefDishLabel.text = dish.description
        caloriesChefsDishLabel.text = dish.formattedCalories
    }
}

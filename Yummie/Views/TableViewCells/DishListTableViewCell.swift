//
//  DishListTableViewCell.swift
//  Yummie
//
//  Created by Наталья Шарапова on 28.04.2022.
//

import UIKit

class DishListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var nameDishLabel: UILabel!
    @IBOutlet weak var descriptionDishLabel: UILabel!
    
    // MARK: - Properties
    
    static let identifier = "DishListTableViewCell"
    
    // MARK: - Methods
    
    func setup(dish: Dish) {
        
        dishImageView.kf.setImage(with: dish.image.asURL)
        nameDishLabel.text = dish.name
        descriptionDishLabel.text = dish.description
    }
    
    func setup(order: Order) {
        
        dishImageView.kf.setImage(with: order.dish?.image.asURL)
        nameDishLabel.text = order.dish?.name
        descriptionDishLabel.text = order.name
    }
}

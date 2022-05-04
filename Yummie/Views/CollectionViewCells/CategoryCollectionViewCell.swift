//
//  CategoryCollectionViewCell.swift
//  Yummie
//
//  Created by Наталья Шарапова on 27.04.2022.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    // MARK: - Properties
    
    static let identifier = "CategoryCollectionViewCell"
    
    // MARK: - Methods
    
    func setupCategoryCollectionViewCell(category: DishCategory) {
        
        categoryNameLabel.text = category.title
        categoryImageView.kf.setImage(with: category.image.asURL)
    }
}

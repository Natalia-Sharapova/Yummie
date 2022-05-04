//
//  OnboardingCollectionViewCell.swift
//  Yummie
//
//  Created by Наталья Шарапова on 23.04.2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    // MARK: - Properties
    
    static let identifier: String = "OnboardingCollectionViewCell"
    
    // MARK: - Methods
    func setupSlide(_ model: OnboardingSlide) {
        
        slideImageView.image = model.image
        slideTitleLabel.text = model.title
        slideDescriptionLabel.text = model.description
    }
}

//
//  DishDetailViewController.swift
//  Yummie
//
//  Created by Наталья Шарапова on 28.04.2022.
//

import UIKit
import ProgressHUD

class DishDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var nameDishLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var orderTextField: UITextField!
    
    // MARK: - Properties
    
    var dish: Dish!
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        
        dishImage.kf.setImage(with: dish.image.asURL)
        nameDishLabel.text = dish.name
        caloriesLabel.text = dish.formattedCalories
        descriptionLabel.text = dish.description
    }
    
    // MARK: - Actions
    
    @IBAction func orderButtonClicked(_ sender: UIButton) {
        
        guard let name = orderTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            ProgressHUD.showError("Please enter your name")
            return
        }
        ProgressHUD.show("Placing order...")
        
        APICaller.shared.submitOrder(forDishId: dish.id, name: name) { (result) in
            
            switch result {
            case .success(_):
                ProgressHUD.showSuccess("Order has been received.👩‍🍳")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}

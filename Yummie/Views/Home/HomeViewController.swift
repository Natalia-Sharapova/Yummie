//
//  HomeViewController.swift
//  Yummie
//
//  Created by Наталья Шарапова on 25.04.2022.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var chefsCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var categories: [DishCategory] = []
    var popularDishes: [Dish] = []
    var chefsDishes: [Dish] = []
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Yummie"
        
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        popularCollectionView.register(UINib(nibName: PopularCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        
        chefsCollectionView.register(UINib(nibName: ChefsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ChefsCollectionViewCell.identifier)
        
        ProgressHUD.show()
        
        APICaller.shared.getAllCategories { result in
            
            switch result {
            
            case .success(let allDishes):
                ProgressHUD.dismiss()
                self.categories = allDishes.data.categories
                self.popularDishes = allDishes.data.populars
                self.chefsDishes = allDishes.data.specials
                
                DispatchQueue.main.async {
                    self.popularCollectionView.reloadData()
                    self.chefsCollectionView.reloadData()
                    self.categoryCollectionView.reloadData()
                }
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}

// MARK: - Extensions

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        
        case categoryCollectionView:
            return categories.count
            
        case popularCollectionView:
            return popularDishes.count
            
        case chefsCollectionView:
            return chefsDishes.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        
        case categoryCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            
            cell.setupCategoryCollectionViewCell(category: categories[indexPath.row])
            return cell
            
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
            cell.setup(dish: popularDishes[indexPath.row])
            return cell
            
        case chefsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChefsCollectionViewCell.identifier, for: indexPath) as! ChefsCollectionViewCell
            cell.setup(dish: chefsDishes[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoryCollectionView {
            
            let controller = DishListViewController.instantiate()
            
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            
        } else {
            let controller = DishDetailViewController.instantiate()
            
            controller.dish = collectionView == popularCollectionView ? popularDishes[indexPath.row] : chefsDishes[indexPath.row]
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

//
//  DishListViewController.swift
//  Yummie
//
//  Created by Наталья Шарапова on 29.04.2022.
//

import UIKit
import ProgressHUD

class DishListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var category: DishCategory!
    var dishes: [Dish] = []
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.title
        
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
        
        ProgressHUD.show()
        
        APICaller.shared.fetchCategoryDishes(categoryId: category.id) { result in
            
            switch result {
            case .success(let dishes):
                
                ProgressHUD.dismiss()
                self.dishes = dishes
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}

// MARK: - Extensions

extension DishListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishListTableViewCell", for: indexPath) as! DishListTableViewCell
        
        cell.setup(dish: dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = DishDetailViewController.instantiate()
        controller.dish = dishes[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

//
//  OrderListViewController.swift
//  Yummie
//
//  Created by Наталья Шарапова on 29.04.2022.
//


import UIKit
import ProgressHUD

class OrderListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var orders: [Order] = []
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Orders"
        
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
        
        ProgressHUD.show()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        APICaller.shared.fetchOrders { result in
            switch result {
            case .success(let orders):
                ProgressHUD.dismiss()
                self.orders = orders
                
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

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as! DishListTableViewCell
        cell.setup(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = DishDetailViewController.instantiate()
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            
            self.orders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        default:
            break
        }
    }
}

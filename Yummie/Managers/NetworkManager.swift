//
//  NetworkManager.swift
//  Yummie
//
//  Created by Наталья Шарапова on 29.04.2022.
//

import Foundation

struct Constants {
    
    static let baseURL = "https://yummie.glitch.me"
    static let fetchAllCategoriesAPI = "/dish-categories"
    static let placeOrder = "/orders/"
    static let fetchCategoryDishes = "/dishes/"
    static let fetchOrders = "/orders"
}

struct APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    // MARK: GET methods
    
    func fetchCategoryDishes(categoryId: String, completion: @escaping(Result<[Dish], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.fetchCategoryDishes)?.appendingPathComponent(categoryId) else { return
        }
        
        let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data else {
                completion(.failure(AppError.invalideUrl))
                return
            }
            do {
                let decoder = JSONDecoder()
                
                guard let response = try decoder.decode(ApiResponseGetCategoryDishes?.self, from: data) else {
                    completion(.failure(AppError.errorDecoding))
                    return
                }
                
                if let error = response.error {
                    completion(.failure(AppError.serverError(error)))
                }
                
                if let decodedData = response.data {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(AppError.unknownError))
                }
            }
            catch {
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    func fetchOrders(completion: @escaping(Result<[Order], Error>) -> Void) {
        
        guard let url = (Constants.baseURL + Constants.fetchOrders).asURL else { return }
        
        let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data else {
                completion(.failure(AppError.invalideUrl))
                return
            }
            do {
                let decoder = JSONDecoder()
                guard let response = try decoder.decode(ApiResponseGetOrders?.self, from: data) else {
                    completion(.failure(AppError.errorDecoding))
                    return
                }
                
                if let error = response.error {
                    completion(.failure(AppError.serverError(error)))
                } 
                
                if let decodedData = response.data {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(AppError.unknownError))
                }
            }
            catch {
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    func getAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void) {
        
        guard let url = (Constants.baseURL + Constants.fetchAllCategoriesAPI).asURL else { return }
        
        let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data else {
                completion(.failure(AppError.invalideUrl))
                return
            }
            DispatchQueue.main.async {
                do {
                    
                    let decoder = JSONDecoder()
                    guard let response = try decoder.decode(AllDishes?.self, from: data) else {
                        completion(.failure(AppError.errorDecoding))
                        return
                    }
                    completion(.success(response))
                }
                catch {
                    print(#line, String(describing: error))
                }
            }
        }
        dataTask.resume()
    }
    
    // MARK: POST methods
    
    func submitOrder(forDishId dishId: String, name: String, completion: @escaping(Result<Order, Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.placeOrder)?.appendingPathComponent(dishId) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = ["name": name]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: data, options: [])
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            var result: Result<Data, Error>?
            
            guard let data = data else {
                completion(.failure(AppError.invalideUrl))
                return
            }
            
            result = .success(data)
            
            let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
            print("The response is: \(responseString)")
            
            DispatchQueue.main.async {
                
                switch result {
                
                case .success(let data):
                    
                    let decoder = JSONDecoder()
                    guard let response = try? decoder.decode(ApiResponseSubmitOrder.self, from: data) else {
                        
                        completion(.failure(AppError.errorDecoding))
                        return }
                    
                    if let error = response.error {
                        completion(.failure(AppError.serverError(error)))
                    }
                    
                    if let decodedData = response.data {
                        completion(.success(decodedData))
                    } else {
                        completion(.failure(AppError.unknownError))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                    
                default:
                    break
                }
            }
        }
        task.resume()
    }
}

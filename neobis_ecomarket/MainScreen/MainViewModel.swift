//
//  MainViewModel.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 5/11/23.
//

import Foundation
import UIKit
import CoreData

protocol MainProtocol {
    var productList: (([ProductItem]) -> Void)? { get set }
    
    func fetchProducts(completion: @escaping ([ProductItem]) -> Void)
}

class MainViewModel: MainProtocol {
    
    let apiService: APIService
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        self.apiService = APIService()
    }
    
    var productList: (([ProductItem]) -> Void)?
    
    func fetchProducts(completion: @escaping ([ProductItem]) -> Void) {
        apiService.get(endpoint: "product-list/") { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let productDTOs = try decoder.decode([ProductItemDTO].self, from: data)
                    
                    var products = [ProductItem]()
                    
                    for productDTO in productDTOs {
                        let product = ProductItem(context: self.context)
                        product.id = Int32(productDTO.id)
                        product.title = productDTO.title
                        product.descr = productDTO.description
                        product.category = "\(productDTO.category)"
                        product.image = "\(productDTO.image)"
                        product.quantity = Int32(productDTO.quantity)
                        product.price = productDTO.price
                        products.append(product)
                    }
                    
                    try self.context.save()
                    completion(products)
                } catch {
                    print("Error decoding JSON:", error)
                    completion([])
                }
            case .failure(let error):
                print("API request failed:", error)
                completion([])
            }
        }
    }
}


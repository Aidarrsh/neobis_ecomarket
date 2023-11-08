//
//  OrderViewModel.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 7/11/23.
//

import Foundation
import UIKit

protocol OrderProtocol {
    var isOrdered: Bool { get }
    var orderResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func order(products: [ProductItem], phone_number: String, adress: String, reference_point: String, comments: String, completion: @escaping (Result<[String: Any], Error>) -> Void)
}


class OrderViewModel: OrderProtocol {
    
    var isOrdered = false
    
    var orderResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func order(products: [ProductItem], phone_number: String, adress: String, reference_point: String, comments: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let parameters: [String: Any] = [
            "products": products.map { productItem in
                return [
                    "product": Int(productItem.id),
                    "quantity": Int(productItem.count)
                ]
            },
            "phone_number": phone_number,
            "address": adress,
            "reference_point": reference_point,
            "comments": comments
        ]
        apiService.post(endpoint: "order-create/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

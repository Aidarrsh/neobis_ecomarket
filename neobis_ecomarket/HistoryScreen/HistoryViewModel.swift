//
//  HistoryViewModel.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 7/11/23.
//

import Foundation
import UIKit

protocol HistoryProtocol {
    var orderList: (([OrderData]) -> Void)? { get set }
    
    func fetchOrders(completion: @escaping ([OrderData]) -> Void)
}

class HistoryViewModel: HistoryProtocol {
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    var orderList: (([OrderData]) -> Void)?
    
    func fetchOrders(completion: @escaping ([OrderData]) -> Void) {
        apiService.get(endpoint: "order-list/") { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let orders = try decoder.decode([OrderData].self, from: data)
                    completion(orders)
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

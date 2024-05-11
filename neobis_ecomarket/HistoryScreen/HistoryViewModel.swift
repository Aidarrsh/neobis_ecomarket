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
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                do {
                    let orders = try decoder.decode([OrderData].self, from: data)
                    completion(orders)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Failed to decode due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
                } catch DecodingError.typeMismatch(_, let context) {
                    print("Failed to decode due to type mismatch – \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    print("Failed to decode due to missing \(type) value – \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    print("Failed to decode due to data being corrupted or the wrong format – \(context.debugDescription)")
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("API request failed: \(error.localizedDescription)")
            }
        }
    }

}

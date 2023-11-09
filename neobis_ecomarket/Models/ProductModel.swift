//
//  ProductModel.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 27/10/23.
//

import Foundation
import CoreData

struct Product {
    var image : String
    var name : String
}

struct ProductItemDTO: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: Int
    let image: String
    let quantity: Int
    let price: String
}

struct Bag {
    let sum: Int
}

struct OrderResponse: Codable {
    let order_number: Int
    let phone_number: String
    let address: String
    let reference_point: String
    let comments: String
    let total_amount: String
    let created_at: String
}


struct OrderData: Codable {
    let order_number: Int
    let phone_number: String
    let address: String
    let reference_point: String
    let comments: String
    let total_amount: String
    let created_at: String
    let delivery_cost: Int
    let ordered_products: [OrderedProduct]
}

struct OrderedProduct: Codable {
    let product: Int
    let quantity: Int
}

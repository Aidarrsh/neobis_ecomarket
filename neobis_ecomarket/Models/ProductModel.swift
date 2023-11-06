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

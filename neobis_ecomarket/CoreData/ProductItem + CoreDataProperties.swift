//
//  ProductItem + CoreDataProperties.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 2/11/23.
//

import Foundation
import CoreData


extension ProductItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ProductItem")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var descr: String?

}

extension ProductItem : Identifiable {

}

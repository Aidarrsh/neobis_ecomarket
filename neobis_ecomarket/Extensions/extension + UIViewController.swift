//
//  extension + UIViewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 2/11/23.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    func save(value: String) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "ProductItem", in: context) else { return }
            
            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)
            
            newValue.setValue(value, forKey: "descr")
            
            do {
                try context.save()
                print("saved \(value)")
            } catch {
                print("error")
            }
        }
    }
    
    func retrieveValues() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<ProductItem>(entityName: "ProductItem")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results {
                    print(result.id)
                }
            } catch {
                print("error")
            }
        }
    }
    
    func deleteValues() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductItem")
            
            do {
                let objects = try context.fetch(fetchRequest)
                for case let object as NSManagedObject in objects {
                    context.delete(object)
                }
                
                try context.save()
            } catch {
                print("Error clearing Core Data: \(error)")
            }
        }
    }
}

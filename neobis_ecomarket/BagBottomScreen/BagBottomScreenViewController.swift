//
//  BagBottomScreen.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import Foundation
import UIKit
import SnapKit
import CoreData

class BagBottomSheet: UIViewController {
    
    private let contentView = BagBottomView()
    var productItems = [ProductItem]()
    var items = [ProductItem]()
    var bag: BagItem?
    var totalPrice: Int?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(CustomBagCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        fetchData()
        setupView()
        addTargets()
    }
    
    func setupView() {
        navigationController?.navigationBar.isUserInteractionEnabled = false
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.orderButton.addTarget(self, action: #selector(orderButtonPressed), for: .touchUpInside)
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<ProductItem> = ProductItem.fetchRequest()
        
        do {
            productItems = try context.fetch(fetchRequest)
            
            // Filter the products with count greater than zero
            items = productItems.filter { $0.count > 0 }
            
            items.sort { $0.title ?? "" < $1.title ?? "" }
            
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
            }
        } catch {
            print("Error fetching data: \(error)")
        }


        
        let fetchBagRequest: NSFetchRequest<BagItem> = BagItem.fetchRequest()
        
        do {
            bag = try context.fetch(fetchBagRequest).first
        } catch {
            print("Error fetching data: \(error)")
        }
        DispatchQueue.main.async {
            self.contentView.tableView.reloadData()
        }
    }
    
    @objc func orderButtonPressed() {
        let vc = OrderViewController(totalPrice: totalPrice ?? 0)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

extension BagBottomSheet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomBagCell
        let totalRowsInSection = tableView.numberOfRows(inSection: indexPath.section)
        if indexPath.row == totalRowsInSection - 1 {
            cell.price = Int(bag?.sumPrice ?? 0)
            cell.sumLabelCount.text = "\(cell.sum) c"
            cell.totalLabelCount.text = "\(cell.sum + 150) c"
            totalPrice = cell.sum + 150
            cell.hideElements()
        } else {
            let product = items[indexPath.row]
            if let photoURLString = product.image, let photoURL = URL(string: photoURLString) {
                cell.image.kf.setImage(with: photoURL) { result in }
            }
            if let priceString = product.price, let price = Double(priceString) {
                let priceWithoutDecimal = Int(price)
                cell.priceLabel.text = "\(priceWithoutDecimal)"
                cell.descriptionLabel.text = "Цена \(priceWithoutDecimal) с за шт"
            } else {
                cell.priceLabel.text = "N/A"
            }
            cell.titleLabel.text = product.title
            cell.productCount = Int(product.count)
            cell.countLabel.text = "\(product.count)"
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
}

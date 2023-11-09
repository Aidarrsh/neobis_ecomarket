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

protocol BagBottomSheetDelegate: AnyObject {
    func bottomBagSheetDismissed()
}

class BagBottomSheet: UIViewController {
    
    weak var delegate: BagBottomSheetDelegate?
    private let contentView = BagBottomView()
    var productItems = [ProductItem]()
    var items = [ProductItem]()
    var bag: BagItem?
    var totalPrice: Int?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let alertView = BagAlertView()
    var blurEffectView: UIVisualEffectView?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.bottomBagSheetDismissed()
    }
    
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
    
    func presentAlert() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView?.alpha = 0.6
        view.addSubview(blurEffectView!)
        view.addSubview(alertView)
        alertView.quitButton.addTarget(self, action: #selector(quitButtonPressed), for: .touchUpInside)

        alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(flexibleWidth(to: 343))
            make.height.equalTo(flexibleHeight(to: 414))
        }
        
        alertView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.3) {
            self.alertView.transform = .identity
        }
    }
    
    @objc func orderButtonPressed() {
        if totalPrice ?? 0 > 450 {
            let vc = OrderViewController(orderProtocol: OrderViewModel(),totalPrice: totalPrice ?? 0, items: items)
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        } else {
            presentAlert()
        }
    }
    
    @objc func plusButtonPressed(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: contentView.tableView)
        if let indexPath = contentView.tableView.indexPathForRow(at: point) {
            let selectedItem = items[indexPath.row]
            if let matchingProductItem = productItems.first(where: { $0.id == selectedItem.id }) {
                if matchingProductItem.count < 50 {
                    matchingProductItem.count += 1
                    if let cell = contentView.tableView.cellForRow(at: indexPath) as? CustomBagCell {
                        cell.productCount = Int(matchingProductItem.count)
                        cell.countLabel.text = "\(cell.productCount)"
                        if let priceText = cell.priceLabel.text, let price = Int(priceText) {
                            bag?.sumPrice += Int32(price)
                            DispatchQueue.main.async {
                                self.contentView.tableView.reloadData()
                            }
                        }
                        cell.price = Int(bag?.sumPrice ?? 0)
                        cell.sumLabelCount.text = "\(cell.sum) c"
                    }
                }
            }
        }
    }

    @objc func minusButtonPressed(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: contentView.tableView)
        if let indexPath = contentView.tableView.indexPathForRow(at: point) {
            let selectedItem = items[indexPath.row]
            if let matchingProductItem = productItems.first(where: { $0.id == selectedItem.id }) {
                if matchingProductItem.count > 0 {
                    matchingProductItem.count -= 1
                    if let cell = contentView.tableView.cellForRow(at: indexPath) as? CustomBagCell {
                        cell.productCount = Int(matchingProductItem.count)
                        cell.countLabel.text = "\(cell.productCount)"
                        if let priceText = cell.priceLabel.text, let price = Int(priceText) {
                            bag?.sumPrice -= Int32(price)
                            DispatchQueue.main.async {
                                self.contentView.tableView.reloadData()
                            }
                        }
                        
                        if let price = Double(selectedItem.price ?? "0") {
                            let priceWithoutDecimal = Int(price)
                            let total = priceWithoutDecimal * Int(matchingProductItem.count)
                            cell.sumLabelCount.text = "\(total) c"
                            
                        }
                        
                        if matchingProductItem.count == 0 {
                            if let indexPath = contentView.tableView.indexPath(for: cell) {
                                items.remove(at: indexPath.row)
                                contentView.tableView.deleteRows(at: [indexPath], with: .fade)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func deleteButtonPressed(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: contentView.tableView)
        if let indexPath = contentView.tableView.indexPathForRow(at: point) {
            let selectedItem = items[indexPath.row]
            if let matchingProductItem = productItems.first(where: { $0.id == selectedItem.id }) {
                
                if let cell = contentView.tableView.cellForRow(at: indexPath) as? CustomBagCell {
                    cell.productCount = Int(matchingProductItem.count)
                    cell.countLabel.text = "\(cell.productCount)"
                    
                    if let price = Double(selectedItem.price ?? "0") {
                        let priceWithoutDecimal = Int(price)
                        let total = priceWithoutDecimal * Int(matchingProductItem.count)
                        bag?.sumPrice -= Int32(total)
                        
                    }
                    
                    if let indexPath = contentView.tableView.indexPath(for: cell) {
                        items.remove(at: indexPath.row)
                        contentView.tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                    
                    matchingProductItem.count = 0
                    
                    DispatchQueue.main.async {
                        self.contentView.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func quitButtonPressed() {
        blurEffectView?.removeFromSuperview()
        alertView.removeFromSuperview()
    }
}

extension BagBottomSheet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            contentView.tableView.isHidden = true
            contentView.orderButton.isHidden = true
        } else {
            contentView.tableView.isHidden = false
            contentView.orderButton.isHidden = false
        }
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
            cell.plusButton.tag = indexPath.row
            cell.plusButton.addTarget(self, action: #selector(plusButtonPressed(sender:)), for: .touchUpInside)
            cell.minusButton.tag = indexPath.row
            cell.minusButton.addTarget(self, action: #selector(minusButtonPressed(sender:)), for: .touchUpInside)
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonPressed(sender:)), for: .touchUpInside)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }

}

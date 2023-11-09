//
//  ListVewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 29/10/23.
//

import UIKit
import SnapKit
import CoreData
import Kingfisher
import Reachability

class ListViewController: UIViewController {
    
    let contentView = ListView()
    var row: Int
    var productItems = [ProductItem]()
    var dynamicItems = [ProductItem]()
    var items = [ProductItem]()
    var productsCount: Int?
    var bag: BagItem?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let alertView = MainAlertView()
    var blurEffectView: UIVisualEffectView?
    
    init(row: Int) {
        self.row = row
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        contentView.productCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
        chooseSection()
        addTargets()
    }
    
    func setupView() {
        navigationController?.navigationBar.isUserInteractionEnabled = false
        contentView.sectionCollectionView.register(CustomListCell.self, forCellWithReuseIdentifier: "MyCellReuseIdentifier")
        contentView.productCollectionView.register(CustomProductCell.self, forCellWithReuseIdentifier: "MyCellReuseIdentifier")
        contentView.sectionCollectionView.delegate = self
        contentView.sectionCollectionView.dataSource = self
        contentView.productCollectionView.delegate = self
        contentView.productCollectionView.dataSource = self
        contentView.searchBar.delegate = self
        view.addSubview(contentView)
        
        contentView.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets(){
        contentView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        contentView.basketButton.addTarget(self, action: #selector(bagButtonPressed), for: .touchUpInside)
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<ProductItem> = ProductItem.fetchRequest()
        
        do {
            productItems = try context.fetch(fetchRequest)
            contentView.productCollectionView.reloadData()
            productItems.sort { $0.title ?? "" < $1.title ?? "" }
            
        } catch {
            print("Error fetching data: \(error)")
        }
        
        let fetchBagRequest: NSFetchRequest<BagItem> = BagItem.fetchRequest()
        
        do {
            bag = try context.fetch(fetchBagRequest).first
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func chooseSection() {
        dynamicItems.removeAll()
        if row == 0 {
            dynamicItems = productItems
            productsCount = productItems.count
        } else if row == 1 {
            for productItem in productItems {
                if productItem.category == "1" {
                    dynamicItems.append(productItem)
                }
            }
        } else if row == 2 {
            for productItem in productItems {
                if productItem.category == "2" {
                    dynamicItems.append(productItem)
                }
            }
        } else if row == 3 {
            for productItem in productItems {
                if productItem.category == "3" {
                    dynamicItems.append(productItem)
                }
            }
        } else if row == 4 {
            for productItem in productItems {
                if productItem.category == "4" {
                    dynamicItems.append(productItem)
                }
            }
        } else if row == 5 {
            for productItem in productItems {
                if productItem.category == "5" {
                    dynamicItems.append(productItem)
                }
            }
        } else if row == 6 {
            for productItem in productItems {
                if productItem.category == "6" {
                    dynamicItems.append(productItem)
                }
            }
        }
        productsCount = dynamicItems.count
        items = dynamicItems
        DispatchQueue.main.async {
            self.contentView.productCollectionView.reloadData()
        }
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func productButtonPressed(sender: UIButton) {
        let indexPathRow = sender.tag

        let totalSections = contentView.sectionCollectionView.numberOfSections
        for section in 0..<totalSections {
            let totalItems = contentView.sectionCollectionView.numberOfItems(inSection: section)
            for item in 0..<totalItems {
                if item == indexPathRow {
                    if let cell = contentView.sectionCollectionView.cellForItem(at: IndexPath(item: item, section: section)) as? CustomListCell {
                        cell.isButtonPressed()
                        row = item
                    }
                } else {
                    if let cell = contentView.sectionCollectionView.cellForItem(at: IndexPath(item: item, section: section)) as? CustomListCell {
                        cell.unpressButton()
                    }
                }
            }
        }
        chooseSection()
        DispatchQueue.main.async {
            self.contentView.productCollectionView.reloadData()
        }
    }
    
    @objc func addButtonPressed(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: contentView.productCollectionView)
        if let indexPath = contentView.productCollectionView.indexPathForItem(at: point) {
            let selectedItem = items[indexPath.row]
            if let matchingProductItem = productItems.first(where: { $0.id == selectedItem.id }) {
                matchingProductItem.count += 1
                if let cell = contentView.productCollectionView.cellForItem(at: indexPath) as? CustomProductCell {
                    cell.productCount = Int(matchingProductItem.count)
                    cell.countLabel.text = "\(cell.productCount)"
                    cell.addButton.isHidden = true
                    cell.plusButton.isHidden = false
                    cell.minusButton.isHidden = false
                    cell.countLabel.isHidden = false
                    
                    if let priceText = cell.priceLabel.text, let price = Int(priceText) {
                        bag?.sumPrice += Int32(price)
                        if let sumPrice = bag?.sumPrice {
                            contentView.basketLabel.text = "Корзина \(sumPrice) c"
                        } else {
                            contentView.basketLabel.text = "Корзина"
                        }
                    }
                }
            }
        }
    }

    @objc func plusButtonPressed(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: contentView.productCollectionView)
        if let indexPath = contentView.productCollectionView.indexPathForItem(at: point) {
            let selectedItem = items[indexPath.row]
            if let matchingProductItem = productItems.first(where: { $0.id == selectedItem.id }) {
                if matchingProductItem.count < 50 {
                    matchingProductItem.count += 1
                    if let cell = contentView.productCollectionView.cellForItem(at: indexPath) as? CustomProductCell {
                        cell.productCount = Int(matchingProductItem.count)
                        cell.countLabel.text = "\(cell.productCount)"
                        if let priceText = cell.priceLabel.text, let price = Int(priceText) {
                            bag?.sumPrice += Int32(price)
                            if let sumPrice = bag?.sumPrice {
                                contentView.basketLabel.text = "Корзина \(sumPrice) c"
                            } else {
                                contentView.basketLabel.text = "Корзина"
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func minusButtonPressed(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: contentView.productCollectionView)
        if let indexPath = contentView.productCollectionView.indexPathForItem(at: point) {
            let selectedItem = items[indexPath.row]
            if let matchingProductItem = productItems.first(where: { $0.id == selectedItem.id }) {
                if matchingProductItem.count > 0 {
                    matchingProductItem.count -= 1
                    if let cell = contentView.productCollectionView.cellForItem(at: indexPath) as? CustomProductCell {
                        cell.productCount = Int(matchingProductItem.count)
                        cell.countLabel.text = "\(cell.productCount)"
                        
                        if let priceText = cell.priceLabel.text, let price = Int(priceText) {
                            bag?.sumPrice -= Int32(price)
                            if let sumPrice = bag?.sumPrice {
                                contentView.basketLabel.text = "Корзина \(sumPrice) c"
                            } else {
                                contentView.basketLabel.text = "Корзина"
                            }
                        }
                        
                        if matchingProductItem.count == 0 {
                            cell.addButton.isHidden = false
                            cell.plusButton.isHidden = true
                            cell.minusButton.isHidden = true
                            cell.countLabel.isHidden = true
                        }
                        
                        if bag?.sumPrice == 0 {
                            contentView.basketLabel.text = "Корзина"
                        }
                    }
                }
            }
        }
    }

    @objc func bagButtonPressed() {
        if bag?.sumPrice != 0 {
            let vc = BagBottomSheet()
            vc.delegate = self
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [
                    .custom { _ in
                        return 500
                    }, .large()
                ]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 30
            }
            
            present(vc, animated: true, completion: nil)
        }
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.setTitleColor(UIColor.black, for: .normal)
                cancelButton.titleLabel?.font = UIFont.ttMedium(ofSize: 16)
            }
        }
        
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            if row == 0 {
                items = dynamicItems.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false }
            } else {
                items = dynamicItems.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false && $0.category == "\(row)" }
            }
        } else {
            if row == 0 {
                items = dynamicItems
            } else {
                items = productItems.filter { $0.category == "\(row)" }
            }
        }
        if items.count == 0 {
            contentView.alertImage.isHidden = false
            contentView.alertLabel.isHidden = false
        } else {
            contentView.alertImage.isHidden = true
            contentView.alertLabel.isHidden = true
        }
        contentView.productCollectionView.reloadData()
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == contentView.productCollectionView{
            return items.count
        } else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == contentView.sectionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomListCell
            cell.productButton.tag = indexPath.row
            
            cell.productButton.addTarget(self, action: #selector(productButtonPressed(sender:)), for: .touchUpInside)
            cell.unpressButton()
            
            switch indexPath.row {
            case 0:
                cell.productButton.setTitle("Все", for: .normal)
            case 1:
                cell.productButton.setTitle("Фрукты", for: .normal)
            case 2:
                cell.productButton.setTitle("Сухофрукты", for: .normal)
            case 3:
                cell.productButton.setTitle("Овощи", for: .normal)
            case 4:
                cell.productButton.setTitle("Зелень", for: .normal)
            case 5:
                cell.productButton.setTitle("Чай кофе", for: .normal)
            case 6:
                cell.productButton.setTitle("Молочные продукты", for: .normal)
            default:
                cell.productButton.setTitle("Все", for: .normal)
            }
            
            if row == indexPath.row {
                cell.isButtonPressed()
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomProductCell
            if row == 0 {
                cell.addButton.isHidden = false
                cell.plusButton.isHidden = true
                cell.minusButton.isHidden = true
                cell.countLabel.isHidden = true
                let product = items[indexPath.row]
                if let photoURLString = product.image, let photoURL = URL(string: photoURLString) {
                    cell.image.kf.setImage(with: photoURL) { result in }
                }
                cell.titleLabel.text = product.title
                if let priceString = product.price, let price = Double(priceString) {
                    let priceWithoutDecimal = Int(price)
                    cell.priceLabel.text = "\(priceWithoutDecimal)"
                } else {
                    cell.priceLabel.text = "N/A"
                }
                
                if product.count != 0 {
                    cell.addButton.isHidden = true
                    cell.plusButton.isHidden = false
                    cell.minusButton.isHidden = false
                    cell.countLabel.isHidden = false
                    cell.countLabel.text = "\(product.count)"
                }
                cell.plusButton.tag = indexPath.row
                cell.plusButton.addTarget(self, action: #selector(plusButtonPressed(sender:)), for: .touchUpInside)
                cell.minusButton.tag = indexPath.row
                cell.minusButton.addTarget(self, action: #selector(minusButtonPressed(sender:)), for: .touchUpInside)
                cell.addButton.tag = indexPath.row
                cell.addButton.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
            }
            let filteredProducts = items.filter { $0.category == "\(row)" }
            
            if indexPath.row < filteredProducts.count {
                cell.addButton.isHidden = false
                cell.plusButton.isHidden = true
                cell.minusButton.isHidden = true
                cell.countLabel.isHidden = true
                let product = filteredProducts[indexPath.row]
                if let photoURLString = product.image, let photoURL = URL(string: photoURLString) {
                    cell.image.kf.setImage(with: photoURL) { result in }
                }
                cell.titleLabel.text = product.title
                if let priceString = product.price, let price = Double(priceString) {
                    let priceWithoutDecimal = Int(price)
                    cell.priceLabel.text = "\(priceWithoutDecimal)"
                } else {
                    cell.priceLabel.text = "N/A"
                }
                
                if product.count != 0 {
                    cell.addButton.isHidden = true
                    cell.plusButton.isHidden = false
                    cell.minusButton.isHidden = false
                    cell.countLabel.isHidden = false
                    cell.countLabel.text = "\(product.count)"
                }
                cell.plusButton.tag = indexPath.row
                cell.plusButton.addTarget(self, action: #selector(plusButtonPressed(sender:)), for: .touchUpInside)
                cell.minusButton.tag = indexPath.row
                cell.minusButton.addTarget(self, action: #selector(minusButtonPressed(sender:)), for: .touchUpInside)
                cell.addButton.tag = indexPath.row
                cell.addButton.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == contentView.sectionCollectionView {
            switch indexPath.row {
            case 0:
                return CGSize(width: UIScreen.main.bounds.width * 52 / 375, height: UIScreen.main.bounds.height * 27 / 812)
            case 1:
                return CGSize(width: UIScreen.main.bounds.width * 83 / 375, height: UIScreen.main.bounds.height * 27 / 812)
            case 2:
                return CGSize(width: UIScreen.main.bounds.width * 118 / 375, height: UIScreen.main.bounds.height * 27 / 812)
            case 3:
                return CGSize(width: UIScreen.main.bounds.width * 78 / 375, height: UIScreen.main.bounds.height * 27 / 812)
            case 4:
                return CGSize(width: UIScreen.main.bounds.width * 83 / 375, height: UIScreen.main.bounds.height * 27 / 812)
            case 5:
                return CGSize(width: UIScreen.main.bounds.width * 100 / 375, height: UIScreen.main.bounds.height * 27 / 812)
            case 6:
                return CGSize(width: UIScreen.main.bounds.width * 180 / 375, height: UIScreen.main.bounds.height * 27 / 812)
            default:
                return CGSize(width: UIScreen.main.bounds.width * 83 / 375, height: UIScreen.main.bounds.height * 27 / 812)
            }
        } else {
            return CGSize(width: (UIScreen.main.bounds.width - 50) / 2, height: UIScreen.main.bounds.height * 228 / 812)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == contentView.productCollectionView {
            let bottomSheetVC = ProductBottomSheet(id: Int(items[indexPath.row].id))
            bottomSheetVC.delegate = self
            if let sheet = bottomSheetVC.sheetPresentationController {
                sheet.detents = [
                    .custom { _ in
                        return 500
                    }
                ]
                sheet.prefersGrabberVisible = false
                sheet.preferredCornerRadius = 30
            }
            
            present(bottomSheetVC, animated: true, completion: nil)
        }
    }
}

extension ListViewController: UISheetPresentationControllerDelegate, ProductBottomSheetDelegate, BagBottomSheetDelegate {
    
    func bottomSheetDismissed() {
        self.contentView.productCollectionView.reloadData()
        if bag?.sumPrice != 0 {
            if let sumPrice = bag?.sumPrice {
                contentView.basketLabel.text = "Корзина \(sumPrice) c"
            } else {
                contentView.basketLabel.text = "Корзина"
            }
        }
    }
    
    func bottomBagSheetDismissed() {
        self.contentView.productCollectionView.reloadData()
        if bag?.sumPrice != 0 {
            if let sumPrice = bag?.sumPrice {
                contentView.basketLabel.text = "Корзина \(sumPrice) c"
            } else {
                contentView.basketLabel.text = "Корзина"
            }
        } else {
            contentView.basketLabel.text = "Корзина"
        }
    }
}

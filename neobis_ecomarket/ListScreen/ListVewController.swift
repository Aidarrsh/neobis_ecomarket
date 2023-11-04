//
//  ListVewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 29/10/23.
//

import UIKit
import SnapKit
import CoreData

class ListViewController: UIViewController {
    
    let contentView = ListView()
    var row: Int
    var productItems = [ProductItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(row: Int) {
        self.row = row
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        createItem()
//        deleteValues()
//        retrieveValues()
        setupView()
    }
    
    func setupView() {
        navigationController?.navigationBar.isUserInteractionEnabled = false
        contentView.sectionCollectionView.register(CustomListCell.self, forCellWithReuseIdentifier: "MyCellReuseIdentifier")
        contentView.productCollectionView.register(CustomProductCell.self, forCellWithReuseIdentifier: "MyCellReuseIdentifier")
        contentView.sectionCollectionView.delegate = self
        contentView.sectionCollectionView.dataSource = self
        contentView.productCollectionView.delegate = self
        contentView.productCollectionView.dataSource = self
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        contentView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    func createItem(){
        let newItem = ProductItem(context: context)
        newItem.id = 1
        newItem.name = "яблоки"
        newItem.descr = "вкусные"
        newItem.count = 5
        newItem.price = 50
        
        do {
            try context.save()
            self.retrieveValues()
        }
        catch {
            
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISheetPresentationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == contentView.productCollectionView{
            return 10
        } else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == contentView.sectionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomListCell
            cell.productButton.tag = indexPath.row
            
            cell.productButton.addTarget(self, action: #selector(productButtonPressed(sender:)), for: .touchUpInside)
            
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
            cell.image.image = UIImage(named: "applesImage")
            cell.plusButton.tag = indexPath.row
            cell.plusButton.addTarget(self, action: #selector(plusButtonPressed(sender:)), for: .touchUpInside)
            cell.minusButton.tag = indexPath.row
            cell.minusButton.addTarget(self, action: #selector(minusButtonPressed(sender:)), for: .touchUpInside)
            cell.addButton.tag = indexPath.row
            cell.addButton.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
            
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
        let bottomSheetVC = ProductBottomSheet()
        
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
    }
    
    @objc func addButtonPressed(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: contentView.productCollectionView)
        if let indexPath = contentView.productCollectionView.indexPathForItem(at: point) {
            if let cell = contentView.productCollectionView.cellForItem(at: indexPath) as? CustomProductCell {
                cell.productCount += 1
                cell.countLabel.text = "\(cell.productCount)"
                cell.addButton.isHidden = true
                cell.plusButton.isHidden = false
                cell.minusButton.isHidden = false
                cell.countLabel.isHidden = false
                if let priceText = cell.priceLabel.text, let price = Int(priceText) {
                    contentView.basketCount += price
                    contentView.basketLabel.text = "Корзина \(contentView.basketCount) c"
                }
            }
        }
    }
    
    @objc func plusButtonPressed(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: contentView.productCollectionView)
        if let indexPath = contentView.productCollectionView.indexPathForItem(at: point) {
            if let cell = contentView.productCollectionView.cellForItem(at: indexPath) as? CustomProductCell {
                if cell.productCount < 50 {
                    cell.productCount += 1
                    cell.countLabel.text = "\(cell.productCount)"
                    if let priceText = cell.priceLabel.text, let price = Int(priceText) {
                        contentView.basketCount += price
                        contentView.basketLabel.text = "Корзина \(contentView.basketCount) c"
                    }
                }
            }
        }
    }
    
    @objc func minusButtonPressed(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: contentView.productCollectionView)
        if let indexPath = contentView.productCollectionView.indexPathForItem(at: point) {
            if let cell = contentView.productCollectionView.cellForItem(at: indexPath) as? CustomProductCell {
                if cell.productCount > 0 {
                    cell.productCount -= 1
                    cell.countLabel.text = "\(cell.productCount)"
                    if let priceText = cell.priceLabel.text, let price = Int(priceText) {
                        contentView.basketCount -= price
                        contentView.basketLabel.text = "Корзина \(contentView.basketCount) c"
                    }
                }
                
                if cell.productCount == 0 {
                    cell.addButton.isHidden = false
                    cell.plusButton.isHidden = true
                    cell.minusButton.isHidden = true
                    cell.countLabel.isHidden = true
                }
                
                if contentView.basketCount == 0 {
                    contentView.basketLabel.text = "Корзина"
                }
            }
        }
    }
    
}

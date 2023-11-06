//
//  MainViewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 26/10/23.
//

import UIKit
import SnapKit
import CoreData

class MainViewController: UIViewController {
    
    let contentView = MainView()
    var mainProtocol: MainProtocol
    var productItems = [ProductItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(mainProtocol: MainProtocol) {
        self.mainProtocol = mainProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fetchData()
    }
    
    func setupViews() {
        view.addSubview(contentView)
        
        contentView.collectionView.register(CustomMainViewCell.self, forCellWithReuseIdentifier: "MyCellReuseIdentifier")
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    let models = [
        Product(image: "fruitsImage", name: "\nФрукты"),
        Product(image: "driedFruitsImage", name: "\nСухофрукты"),
        Product(image: "vegetablesImage", name: "\nОвощи"),
        Product(image: "greensImage", name: "\nЗелень"),
        Product(image: "teaImage", name: "\nЧай кофе"),
        Product(image: "milkImage", name: "Молочные продукты")
    ]
    
    func fetchData() {
        if checkCount() == 0 {
            
            mainProtocol.fetchProducts() { products in
                
            }
        }
        let fetchRequest: NSFetchRequest<ProductItem> = ProductItem.fetchRequest()
        
        do {
            productItems = try context.fetch(fetchRequest)
            contentView.collectionView.reloadData()
            productItems.sort { $0.title ?? "" < $1.title ?? "" }
            
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomMainViewCell
        let product = models[indexPath.row]
        cell.image.image = UIImage(named: product.image)
        cell.titleLabel.text = product.name
        cell.button.tag = indexPath.row + 1
        cell.button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let vc = ListViewController(row: sender.tag)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

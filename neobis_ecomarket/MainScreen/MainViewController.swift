//
//  MainViewController.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 26/10/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let contentView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
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
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomMainViewCell
        let product = models[indexPath.row]
//        cell.button.setImage(UIImage(named: product.image), for: .normal)
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

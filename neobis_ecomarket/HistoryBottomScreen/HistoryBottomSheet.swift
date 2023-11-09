//
//  OrderBottomSheet.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 9/11/23.
//

import Foundation
import UIKit
import SnapKit
import CoreData
import Kingfisher

class HistoryBottomSheet: UIViewController {
    
    let orderNumber: Int
    let orderTime: String
    let price: Int
    let orderedProducts: [OrderedProduct]
    var items = [ProductItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(orderNumber: Int, orderTime: String, price: Int, orderedProducts: [OrderedProduct]) {
        self.orderNumber = orderNumber
        self.orderTime = orderTime
        self.price = price
        self.orderedProducts = orderedProducts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#75DB1B")
        
        return view
    }()
    
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Заказ №\(orderNumber)"
        label.textColor = .white
        label.font = UIFont.interSemiBold(ofSize: 16)
        
        return label
    }()
    
    lazy var checkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "checkImage")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = UIScreen.main.bounds.height * 37 / 812
        
        return image
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Оформлен \(orderTime)"
        label.font = UIFont.interSemiBold(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "\(price) c"
        label.font = UIFont.ttBold(ofSize: 32)
        label.textColor = .white
        
        return label
    }()
    
    lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Доставка 150 с"
        label.font = UIFont.interSemiBold(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        view.separatorStyle = .none
        
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.backgroundColor = UIColor(hex: "#75DB1B")
        button.titleLabel?.font = UIFont.interSemiBold(ofSize: 16)
        button.layer.cornerRadius = UIScreen.main.bounds.height * 16 / 812
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupView()
        setupConstraints()
        addTargets()
    }
    
    func setupView() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomHistoryBottomCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
        view.addSubview(greenView)
        view.addSubview(orderLabel)
        view.addSubview(checkImage)
        view.addSubview(timeLabel)
        view.addSubview(priceLabel)
        view.addSubview(deliveryLabel)
        view.addSubview(tableView)
        view.addSubview(closeButton)
    }
    
    func setupConstraints() {
        greenView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 252))
        }
        
        orderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 32))
            make.centerX.equalToSuperview()
        }
        
        checkImage.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(flexibleHeight(to: 4))
            make.centerX.equalToSuperview()
            make.height.width.equalTo(flexibleHeight(to: 74))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(checkImage.snp.bottom).offset(flexibleHeight(to: 12))
            make.centerX.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(flexibleHeight(to: 4))
            make.centerX.equalToSuperview()
        }
        
        deliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(flexibleHeight(to: 4))
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).offset(flexibleHeight(to: 16))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 54))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 50))
        }
    }
    
    func addTargets() {
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<ProductItem> = ProductItem.fetchRequest()
        
        do {
            items = try context.fetch(fetchRequest)
            items.sort { $0.title ?? "" < $1.title ?? "" }
            
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true)
    }
}

extension HistoryBottomSheet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomHistoryBottomCell
        let product = orderedProducts[indexPath.row]
        if let matchingProduct = items.first(where: { $0.id == product.product })  {
    
            if let photoURLString = matchingProduct.image, let photoURL = URL(string: photoURLString) {
                cell.productImage.kf.setImage(with: photoURL) { result in }
            }
            
            cell.titleLabel.text = matchingProduct.title
            cell.quantityLabel.text = "\(product.quantity) шт"
            if let priceString = matchingProduct.price, let price = Double(priceString) {
                let priceWithoutDecimal = Int(price)
                cell.priceOneLabel.text = "Цена \(priceWithoutDecimal) с за шт"
                cell.priceLabel.text = "\(product.quantity * priceWithoutDecimal)"
            } else {
                cell.priceOneLabel.text = "N/A"
            }
            
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
}
